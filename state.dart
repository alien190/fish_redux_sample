import 'dart:async';
import 'dart:typed_data';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'base_message_state.dart';
import 'text_message_component/state.dart';
import 'message_list_component/state.dart';
import 'reminder_component/state.dart';
import 'send_message_component/state.dart' as send;

class ChatState implements Cloneable<ChatState> {
  static const String chatRoomIdKey = 'chatRoomIdKey';
  static const String anotherUserIdKey = 'anotherUserIdKey';
  static const String anotherUserNameKey = 'anotherUserNameKey';
  static const String anotherUserPictureKey = 'anotherUserPictureKey';
  static const String isReadOnlyKey = 'isReadOnlyKey';

  List<BaseMessageState> liveMessages;
  List<BaseMessageState> paginatedMessages;
  List<BaseMessageState> actionMessages;
  List<StreamSubscription> subscriptions;
  bool isMessagePaginationEnabled;
  bool isNewMessages;
  bool isTheBottomReached;
  String chatRoomId;
  ScrollController scrollController;
  double maxScrollExtent;
  String anotherUserId;
  String anotherUserName;
  Uint8List anotherUserPicture;
  int lastFetchedTimestamp;
  send.SendMessageState sendMessageState;
  bool isReadOnly;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ChatState clone() {
    return ChatState()
      ..liveMessages = liveMessages
      ..paginatedMessages = paginatedMessages
      ..subscriptions = subscriptions
      ..isMessagePaginationEnabled = isMessagePaginationEnabled
      ..isNewMessages = isNewMessages
      ..chatRoomId = chatRoomId
      ..isTheBottomReached = isTheBottomReached
      ..scrollController = scrollController
      ..maxScrollExtent = maxScrollExtent
      ..anotherUserId = anotherUserId
      ..lastFetchedTimestamp = lastFetchedTimestamp
      ..anotherUserName = anotherUserName
      ..anotherUserPicture = anotherUserPicture
      ..sendMessageState = sendMessageState
      ..isReadOnly = isReadOnly
      ..actionMessages = actionMessages
      ..scaffoldKey = scaffoldKey;
  }
}

ChatState initState(Map<String, dynamic> arguments) {
  final String chatRoomId = arguments[ChatState.chatRoomIdKey];
  final String anotherUserId = arguments[ChatState.anotherUserIdKey];
  final String anotherUserName = arguments[ChatState.anotherUserNameKey];
  final Uint8List anotherUserPicture =
      arguments[ChatState.anotherUserPictureKey];
  final bool isReadOnly = arguments[ChatState.isReadOnlyKey];

  return ChatState()
    ..chatRoomId = chatRoomId
    ..anotherUserId = anotherUserId
    ..anotherUserName = anotherUserName
    ..anotherUserPicture = anotherUserPicture
    ..liveMessages = []
    ..paginatedMessages = []
    ..isMessagePaginationEnabled = true
    ..isNewMessages = false
    ..isTheBottomReached = true
    ..subscriptions = []
    ..lastFetchedTimestamp = 0
    ..sendMessageState = (send.initState(null)..chatRoomId = chatRoomId)
    ..isReadOnly = isReadOnly ?? false
    ..actionMessages = []
    ..scaffoldKey = GlobalKey<ScaffoldState>();
}

class LiveMessagesConnector extends ConnOp<ChatState, MessageListState>
    with ReselectMixin<ChatState, MessageListState> {
  @override
  MessageListState computed(ChatState state) {
    return MessageListState()
      ..messages = state.liveMessages
      ..isPaginationEnabled = false
      ..isBuildNotificationEnable = true;
  }

  @override
  List<dynamic> factors(ChatState state) {
    return <int>[state.liveMessages.length];
  }

  @override
  void set(ChatState state, MessageListState subState) {}
}

class PaginatedMessageConnector extends ConnOp<ChatState, MessageListState>
    with ReselectMixin<ChatState, MessageListState> {
  @override
  MessageListState computed(ChatState state) {
    return MessageListState()
      ..messages = state.paginatedMessages
      ..isPaginationEnabled = state.isMessagePaginationEnabled
      ..isBuildNotificationEnable = false;
  }

  @override
  List<dynamic> factors(ChatState state) {
    return <int>[
      state.paginatedMessages.length,
      state.isMessagePaginationEnabled ? 1 : 0
    ];
  }

  @override
  void set(ChatState state, MessageListState subState) {}
}

class ActionsMessageConnector extends ConnOp<ChatState, MessageListState>
    with ReselectMixin<ChatState, MessageListState> {
  @override
  MessageListState computed(ChatState state) {
    return MessageListState()
      ..messages = state.actionMessages
      ..isPaginationEnabled = false
      ..isBuildNotificationEnable = false;
  }

  @override
  List<dynamic> factors(ChatState state) {
    return <int>[
      state.actionMessages.length,
    ];
  }

  @override
  void set(ChatState state, MessageListState subState) {}
}

class ReminderConnector extends ConnOp<ChatState, ReminderState>
    with ReselectMixin<ChatState, ReminderState> {
  @override
  ReminderState computed(ChatState state) {
    return ReminderState()..isNewItems = state.isNewMessages;
  }

  @override
  List<dynamic> factors(ChatState state) {
    return <bool>[state.isNewMessages];
  }

  @override
  void set(ChatState state, ReminderState subState) {}
}

class SendMessageConnector extends ConnOp<ChatState, send.SendMessageState> {
  @override
  void set(ChatState state, send.SendMessageState subState) {
    state.sendMessageState = subState;
  }

  @override
  send.SendMessageState get(ChatState state) {
    return state.sendMessageState;
  }
}
