import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:wer_wichtelt/src/ui/global_store/action.dart';
import 'package:wer_wichtelt/src/ui/global_store/store.dart';
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import 'action.dart';
import 'state.dart';
import 'base_message_state.dart';
import 'response_message_component/action.dart';
import 'request_message_component/action.dart';
import 'gift_message_component/action.dart';
import '../../resources/resources.dart';
import 'pagination_component/action.dart';
import '../feedback_page/page.dart';
import '../feedback_page/state.dart';

final Repository _repository = MainRepository();

Effect<ChatState> buildEffect() {
  return combineEffects(<Object, Effect<ChatState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    PaginationAction.onPagination: _onPagination,
    ChatAction.onAddMessage: _onAddPost,
    ChatAction.onListBuildNotification: _onListBuildNotification,
    ChatAction.onSendResponse: _onSendResponse,
    ChatAction.onSendGift: _onSendGift,
    ChatAction.onSendFeedback: _onSendFeedback,
    ChatAction.onAddComplaint: _onAddComplaint,
    ChatAction.onErrorOccurred: _onErrorOccurred,
    ChatAction.onHideKeyboard: _onHideKeyboard,
  });
}

void _init(Action action, Context<ChatState> ctx) {
  print('Effect init chatRoomId:${ctx.state.chatRoomId}');
  _initScrollController(ctx);
  _unsubscribe(ctx);
  _subscribe(ctx);
  _fetchPaginated(ctx.state);
  GlobalStore.store.dispatch(
      GlobalActionCreator.setChatOpenedPageIdAction(ctx.state.chatRoomId));
}

void _initScrollController(Context<ChatState> ctx) {
  final ScrollController scrollController = ScrollController();

  scrollController.addListener(() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!ctx.state.isTheBottomReached) {
        ctx.dispatch(ChatActionCreator.setIsTheBottomReachedAction(true));
      }
    } else {
      if (ctx.state.isTheBottomReached) {
        ctx.dispatch(ChatActionCreator.setIsTheBottomReachedAction(false));
      }
    }
  });

  ctx.dispatch(ChatActionCreator.setScrollControllerAction(scrollController));
}

void _onPagination(Action action, Context<ChatState> ctx) {
  print('_onPagination');
  _fetchPaginated(ctx.state);
}

void _fetchPaginated(ChatState state) async {
  final ChatListDBProvider<ChatBaseMessageModel> chatProvider =
      await _repository.getChatProvider(
          chatRoomId: state.chatRoomId, anotherUserId: state.anotherUserId);
  chatProvider.fetchPaginatedData(15);
}

void _dispose(Action action, Context<ChatState> ctx) {
  print('chat page dispose');
  _unsubscribe(ctx);
  GlobalStore.store.dispatch(GlobalActionCreator.setChatOpenedPageIdAction(''));
}

void _unsubscribe(Context<ChatState> ctx) {
  print('unsubscribe');
  ctx.state.subscriptions?.forEach((sub) => sub?.cancel());
  ctx.state.subscriptions?.clear();
  _repository.disposeChatProvider(ctx.state.chatRoomId);
}

void _subscribe(Context<ChatState> ctx) async {
  final List<StreamSubscription> subscriptions = [];

  final String anotherUserId = ctx.state.anotherUserId;

  final ChatListDBProvider<ChatBaseMessageModel> chatProvider =
      await _repository.getChatProvider(
          chatRoomId: ctx.state.chatRoomId,
          anotherUserId: ctx.state.anotherUserId);

  subscriptions.add(
    chatProvider.paginatedData.listen(
      (List<ChatBaseMessageModel> messages) {
        ctx.dispatch(ChatActionCreator.addPaginatedMessagesAction(
            _convertMessagesToState(messages, anotherUserId)));

        final int lastTimestamp = (messages != null && messages.length > 0)
            ? messages.first.timestamp
            : 0;

        if (lastTimestamp >= ctx.state.lastFetchedTimestamp) {
          _repository.updateLastReadMessageTimestamp(
              ctx.state.chatRoomId, lastTimestamp);
        }
      },
    ),
  );

  subscriptions.add(
    chatProvider.liveData.listen(
      (List<ChatBaseMessageModel> messages) {
        ctx.dispatch(ChatActionCreator.addLiveMessagesAction(
            _convertMessagesToState(messages, anotherUserId)));

        final int lastTimestamp = messages.last.timestamp;
        _repository.updateLastReadMessageTimestamp(
            ctx.state.chatRoomId, lastTimestamp);
      },
    ),
  );

  subscriptions.add(
    chatProvider.isPaginatedDataEnd.listen(
      (bool isEnd) {
        if (isEnd) {
          ctx.dispatch(ChatActionCreator.postPaginationEndAction());
        }
      },
    ),
  );

  subscriptions.add(
    chatProvider.actionItems.listen(
      (List<ChatBaseMessageModel> messages) {
        final List<BaseMessageState> stateList =
            _convertMessagesToState(messages, anotherUserId);
        stateList.removeWhere((BaseMessageState state) => state.isMyMessage);
        ctx.dispatch(ChatActionCreator.addActionMessagesAction(stateList));
      },
    ),
  );

  ctx.dispatch(ChatActionCreator.addSubscriptionAction(subscriptions));
}

List<BaseMessageState> _convertMessagesToState(
    List<ChatBaseMessageModel> messages, String anotherUserId) {
  final List<BaseMessageState> stateList = [];
  messages?.forEach(
    (message) {
      try {
        final BaseMessageState state =
            MessageStateFactory.fromModel(message, anotherUserId);
        if (state != null) {
          stateList.add(state);
        }
      } catch (error) {
        print(error);
      }
    },
  );
  return stateList;
}

void _onAddPost(Action action, Context<ChatState> ctx) {
  _repository.addSamplePost();
}

void _onListBuildNotification(Action action, Context<ChatState> ctx) {
  if (ctx.state.isTheBottomReached) {
    final ScrollController scrollController = ctx.state.scrollController;
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}

void _onSendResponse(Action action, Context<ChatState> ctx) {
  if (action.payload is Map<String, dynamic>) {
    final Map<String, dynamic> map = action.payload;

    final String wishId = map[ChatActionCreator.wishIdKey];
    final String requestId = map[ChatActionCreator.requestIdKey];
    final int giftCategoryIndex = map[ChatActionCreator.giftCategoryIndexKey];

    if (requestId != null &&
        requestId.isNotEmpty &&
        wishId != null &&
        wishId.isNotEmpty) {
      ctx.dispatch(
          RequestMessageActionCreator.showProgressIndicatorAction(requestId));
      _repository
          .sendResponse(
        wishId: wishId,
        requestId: requestId,
        giftCategoryIndex: giftCategoryIndex,
      )
          .then(
//              (_) => ctx.dispatch(
//                  RequestMessageActionCreator.responseWasSendAction(requestId)),

              (_) => ctx.dispatch(
                  RequestMessageActionCreator.hideProgressIndicatorAction(
                      requestId)), onError: (_) {
        ctx.dispatch(ChatActionCreator.onErrorOccurredAction());
        ctx.dispatch(
            RequestMessageActionCreator.hideProgressIndicatorAction(requestId));
      });
    }
  }
}

void _onSendGift(Action action, Context<ChatState> ctx) {
  if (action.payload is Map<String, dynamic>) {
    final Map<String, dynamic> map = action.payload;

    final String responseId = map[ChatActionCreator.idKey];
    final int giftCategoryIndex = map[ChatActionCreator.giftCategoryIndexKey];

    if (responseId.isNotEmpty) {
      ctx.dispatch(
          ResponseMessageActionCreator.showProgressIndicatorAction(responseId));
      _repository
          .sendGift(
        chatRoomId: ctx.state.chatRoomId,
        responseId: responseId,
        giftCategoryIndex: giftCategoryIndex,
      )
          .then(
              (_) => ctx.dispatch(
                  ResponseMessageActionCreator.hideProgressIndicatorAction(
                      responseId)),
//              (_) => ctx.dispatch(
//                  ResponseMessageActionCreator.giftWasSendAction(responseId)
//              ),
              onError: (error) {
        ctx.dispatch(ChatActionCreator.onErrorOccurredAction());
        ctx.dispatch(ResponseMessageActionCreator.hideProgressIndicatorAction(
            responseId));
      });
    }
  }
}

void _onSendFeedback(Action action, Context<ChatState> ctx) async {
  if (action.payload is Map<String, dynamic>) {
    final Map<String, dynamic> map = action.payload;

    final String giftId = map[ChatActionCreator.idKey];
    final int giftCategoryIndex = map[ChatActionCreator.giftCategoryIndexKey];

    if (giftId.isNotEmpty) {
      try {
        ctx.dispatch(
            GiftMessageActionCreator.showProgressIndicatorAction(giftId));

        final result = await FeedbackPage.push(ctx.context);

        if (result != null && result is Map<String, dynamic>) {
          final Uint8List image = result[FeedbackState.imageKey];
          final String message = result[FeedbackState.messageKey];
          final int originalityRate = result[FeedbackState.originalityRateKey];
          final int deliveryRate = result[FeedbackState.deliveryRateKey];
          final int satisfactionRate =
              result[FeedbackState.satisfactionRateKey];

          await _repository.sendFeedback(
            chatRoomId: ctx.state.chatRoomId,
            giftId: giftId,
            image: image,
            message: message,
            originalityRate: originalityRate,
            deliveryRate: deliveryRate,
            satisfactionRate: satisfactionRate,
            anotherUserId: ctx.state.anotherUserId,
            anotherUserName: ctx.state.anotherUserName,
            giftCategoryIndex: giftCategoryIndex,
          );

          ctx.dispatch(
              GiftMessageActionCreator.hideProgressIndicatorAction(giftId));
          //ctx.dispatch(GiftMessageActionCreator.feedbackWasSendAction(giftId));
        } else {
          ctx.dispatch(
              GiftMessageActionCreator.hideProgressIndicatorAction(giftId));
        }
      } catch (error) {
        print(error);
        ctx.dispatch(ChatActionCreator.onErrorOccurredAction());
        ctx.dispatch(
            GiftMessageActionCreator.hideProgressIndicatorAction(giftId));
      }
    }
  }
}

void _onAddComplaint(Action action, Context<ChatState> ctx) async {
  final ChatState chatState = ctx.state;

  _repository.addChatRoomComplain(
    chatRoomId: chatState.chatRoomId,
    complaintUserId: chatState.anotherUserId,
    complaintUserName: chatState.anotherUserName,
  );

  GlobalStore.store.dispatch(
      GlobalActionCreator.addComplaintAction(chatState.anotherUserId));
  Navigator.of(ctx.context).pop();
}

void _onHideKeyboard(Action action, Context<ChatState> ctx) {
  FocusScope.of(ctx.context).unfocus();
}

void _onErrorOccurred(Action action, Context<ChatState> ctx) {
  showError(ctx.state.scaffoldKey);
}
