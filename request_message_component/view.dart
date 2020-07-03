import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import 'state.dart';
import '../action.dart';

Widget buildView(
    RequestMessageState state, Dispatch dispatch, ViewService viewService) {
  return buildChatActionMessage(
    state: state,
    body: Text(
      state.isMyMessage
          ? '${AppStrings.youSentRequest} - ${getCategoryPriceStr(state.giftCategoryIndex)}'
          : '${AppStrings.pleaseAcceptRequest} - ${getCategoryPriceStr(state.giftCategoryIndex)}',
      textAlign: TextAlign.center,
    ),
    actionText: state.isMyMessage ? '' : AppStrings.accept,
    action: state.didResponseSend || state.isMyMessage
        ? null
        : () => _sendResponse(state, dispatch, viewService),
    showProgressIndicator: state.showProgressIndicator,
  );
}

void _sendResponse(
    RequestMessageState state, Dispatch dispatch, ViewService viewService) {
  showAlertDialog(
    context: viewService.context,
    title: AppStrings.request,
    text: AppStrings.acceptRequestQuestion,
    onOkAction: () => dispatch(ChatActionCreator.onSendResponseAction(
        state.wishId, state.id, state.giftCategoryIndex)),
  );
}
