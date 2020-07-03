import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'gift_message_component/state.dart';
import 'request_message_component/state.dart';
import 'response_message_component/state.dart';
import 'state.dart';

//import 'message_component/state.dart';
import 'base_message_state.dart';

Reducer<ChatState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChatState>>{
      ChatAction.addPaginatedMessages: _addPaginatedMessages,
      ChatAction.addLiveMessages: _addLiveMessages,
      ChatAction.addActionMessages: _addActionMessages,
      ChatAction.postPaginationEnd: _postPaginationEnd,
      ChatAction.reachTheBottom: _reachTheBottom,
      ChatAction.addSubscription: _addSubscription,
      ChatAction.setScrollController: _setScrollController,
      ChatAction.setIsTheBottomReached: _setIsTheBottomReached,
    },
  );
}

ChatState _addActionMessages(ChatState state, Action action) {
  if (action.payload is List<BaseMessageState>) {
    final ChatState newState = state.clone();
    newState.actionMessages = action.payload;
    return newState;
  }
  return state;
}

ChatState _addPaginatedMessages(ChatState state, Action action) {
  final ChatState newState = state.clone();
  if (action.payload is List<BaseMessageState>) {
    _addMessages(
        normalMessagesList: newState.paginatedMessages,
        sourceMessages: action.payload);

    _updateLastFetchedTimestamp(newState, action.payload);
  }
  return newState;
}

void _addMessages({
  @required List<BaseMessageState> normalMessagesList,
  @required List<BaseMessageState> sourceMessages,
}) {
  sourceMessages?.forEach((BaseMessageState state) {
    if (state.isMyMessage) {
      normalMessagesList.add(state);
      return;
    }

    switch (state.messageType) {
      case MessageType.text:
        {
          normalMessagesList.add(state);
          break;
        }
      case MessageType.request:
        {
          if ((state as RequestMessageState).didResponseSend) {
            normalMessagesList.add(state);
          }
          break;
        }
      case MessageType.response:
        {
          if ((state as ResponseMessageState).wasGiftSend) {
            normalMessagesList.add(state);
          }
          break;
        }

      case MessageType.gift:
        {
          if ((state as GiftMessageState).wasFeedbackGet) {
            normalMessagesList.add(state);
          }
          break;
        }

      case MessageType.feedback:
        {
          normalMessagesList.add(state);
          break;
        }
    }
  });
}

ChatState _addLiveMessages(ChatState state, Action action) {
  final ChatState newState = state.clone();
  if (action.payload is List<BaseMessageState>) {
    _addMessages(
        normalMessagesList: newState.liveMessages,
        sourceMessages: action.payload);

    _updateLastFetchedTimestamp(newState, action.payload);
  }
  if (state.isTheBottomReached) {
    newState.isNewMessages = false;
  } else {
    newState.isNewMessages = true;
  }
  return newState;
}

void _updateLastFetchedTimestamp(
    ChatState newState, List<BaseMessageState> messageStates) {
  final int lastTimestamp = (messageStates != null && messageStates.length > 0)
      ? messageStates.last.timestamp
      : 0;
  if (lastTimestamp > newState.lastFetchedTimestamp) {
    newState.lastFetchedTimestamp = lastTimestamp;
  }
}

ChatState _postPaginationEnd(ChatState state, Action action) {
  final ChatState newState = state.clone();
  newState.isMessagePaginationEnabled = false;
  return newState;
}

ChatState _reachTheBottom(ChatState state, Action action) {
  final ChatState newState = state.clone();
  newState.isNewMessages = false;
  newState.isTheBottomReached = true;
  return newState;
}

ChatState _addSubscription(ChatState state, Action action) {
  final ChatState newState = state.clone();
  if (action.payload is List<StreamSubscription>) {
    newState.subscriptions = action.payload;
  }
  return newState;
}

ChatState _setScrollController(ChatState state, Action action) {
  final ChatState newState = state.clone();
  if (action.payload is ScrollController) {
    newState.scrollController = action.payload;
  }
  return newState;
}

ChatState _setIsTheBottomReached(ChatState state, Action action) {
  final ChatState newState = state.clone();
  if (action.payload is bool) {
    newState.isTheBottomReached = action.payload;
    if (newState.isTheBottomReached) {
      newState.isNewMessages = false;
    }
  }
  return newState;
}