import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'base_message_state.dart';

enum ChatAction {
  addPaginatedMessages,
  addLiveMessages,
  addActionMessages,
  postPaginationEnd,
  reachTheBottom,
  movedFromTheBottom,
  addSubscription,
  onAddMessage,
  setScrollController,
  setIsTheBottomReached,
  onListBuildNotification,
  onSendResponse,
  onSendGift,
  onSendFeedback,
  onAddComplaint,
  onErrorOccurred,
  onHideKeyboard,
}

class ChatActionCreator {
  static const String wishIdKey = 'wishIdKey';
  static const String requestIdKey = 'requestIdKey';
  static const idKey = 'idKey';
  static const giftCategoryIndexKey = 'giftCategoryIndexKey';

  static Action addPaginatedMessagesAction(List<BaseMessageState> posts) {
    return Action(ChatAction.addPaginatedMessages, payload: posts);
  }

  static Action addLiveMessagesAction(List<BaseMessageState> posts) {
    return Action(ChatAction.addLiveMessages, payload: posts);
  }

  static Action addActionMessagesAction(List<BaseMessageState> posts) {
    return Action(ChatAction.addActionMessages, payload: posts);
  }

  static Action postPaginationEndAction() {    return const Action(ChatAction.postPaginationEnd);  }

  static Action onHideKeyboardAction() {    return const Action(ChatAction.onHideKeyboard);  }

  static Action reachTheBottomAction() {
    return const Action(ChatAction.reachTheBottom);
  }

  static Action movedFromTheBottomAction() {
    return const Action(ChatAction.reachTheBottom);
  }

  static Action onErrorOccurredAction() {
    return const Action(ChatAction.onErrorOccurred);
  }

  static Action addSubscriptionAction(List<StreamSubscription> subscriptions) {
    return Action(ChatAction.addSubscription, payload: subscriptions);
  }

  static Action onAddMessageAction() {
    return const Action(ChatAction.onAddMessage);
  }

  static Action setScrollControllerAction(ScrollController scrollController) {
    return Action(ChatAction.setScrollController, payload: scrollController);
  }

  static Action onListBuildNotificationAction() {
    return const Action(ChatAction.onListBuildNotification);
  }

  static Action setIsTheBottomReachedAction(bool isReached) {
    return Action(ChatAction.setIsTheBottomReached, payload: isReached);
  }

  static Action onSendResponseAction(
      String wishId, String requestId, int giftCategoryIndex) {
    return Action(ChatAction.onSendResponse, payload: <String, dynamic>{
      wishIdKey: wishId,
      requestIdKey: requestId,
      giftCategoryIndexKey: giftCategoryIndex,
    });
  }

  static Action onSendGiftAction(String responseId, int giftCategoryIndex) {
    return Action(ChatAction.onSendGift, payload: <String, dynamic>{
      idKey: responseId,
      giftCategoryIndexKey: giftCategoryIndex,
    });
  }

  static Action onSendFeedbackAction(String responseId, int giftCategoryIndex) {
    return Action(ChatAction.onSendFeedback, payload: <String, dynamic>{
      idKey: responseId,
      giftCategoryIndexKey: giftCategoryIndex,
    });
  }

  static Action onAddComplaintAction() {
    return const Action(ChatAction.onAddComplaint);
  }
}
