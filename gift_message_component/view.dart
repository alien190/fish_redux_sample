import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    GiftMessageState state, Dispatch dispatch, ViewService viewService) {
  return buildChatActionMessage(
    state: state,
    body: Text(
      state.isMyMessage
          ? AppStrings.youSentGift(getCategoryPriceStr(state.giftCategoryIndex))
          : AppStrings.yourGiftWasSend(
              getCategoryPriceStr(state.giftCategoryIndex)),
      textAlign: TextAlign.center,
    ),
    actionText: state.isMyMessage ? '' : AppStrings.iReceiveGift,
    action: state.wasFeedbackGet
        ? null
        : () => dispatch(
              ChatActionCreator.onSendFeedbackAction(
                  state.id, state.giftCategoryIndex),
            ),
    showProgressIndicator: state.showProgressIndicator,
  );
}
