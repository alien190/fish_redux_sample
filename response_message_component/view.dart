import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    ResponseMessageState state, Dispatch dispatch, ViewService viewService) {
  return buildChatActionMessage(
    state: state,
    body: Text(
      state.isMyMessage ? _getMyCaption(state) : _getAnotherUserCaption(state),
      textAlign: TextAlign.center,
    ),
    actionText:
        state.isMyMessage || !state.isAccepted ? '' : AppStrings.iSentGift,
    action: state.wasGiftSend
        ? null
        : () => _sendGift(state, dispatch, viewService),
    showProgressIndicator: state.showProgressIndicator,
  );
}

void _sendGift(
    ResponseMessageState state, Dispatch dispatch, ViewService viewService) {
  showAlertDialog(
    context: viewService.context,
    title: AppStrings.gift,
    text: AppStrings.sendGiftQuestion,
    onOkAction: () => dispatch(
      ChatActionCreator.onSendGiftAction(state.id, state.giftCategoryIndex),
    ),
  );
}

String _getMyCaption(ResponseMessageState state) {
  return state.isAccepted
      ? '${AppStrings.youAcceptedRequest} - ${getCategoryPriceStr(state.giftCategoryIndex)}'
      : '${AppStrings.youDeclinedRequest} - ${getCategoryPriceStr(state.giftCategoryIndex)}';
}

String _getAnotherUserCaption(ResponseMessageState state) {
  return state.isAccepted
      ? AppStrings.yourRequestAccepted(
              getCategoryPriceStr(state.giftCategoryIndex)) +
          ' ${state.text}'
      : AppStrings.yourRequestDeclined(
          getCategoryPriceStr(state.giftCategoryIndex));
}

//return buildChatMessage(
//    state: state,
//    child: ListTile(
//      leading:
//          Image.asset(state.isAccepted ? AppAssets.accept : AppAssets.decline),
//      title: state.isMyMessage
//          ? _buildMyResponse(state)
//          : _buildAnotherUserResponse(state, dispatch),
//    ),
//  );
//Widget _buildAnotherUserResponse(
//    ResponseMessageState state, Dispatch dispatch) {
//  return state.isAccepted
//      ? _buildSendGiftResponse(state, dispatch)
//      : Text(AppStrings.yourRequestDeclined);
//}
//
//Widget _buildSendGiftResponse(ResponseMessageState state, Dispatch dispatch) {
//  final String commonText = '${AppStrings.yourRequestAccepted} ${state.text}';
//
//  final String text = commonText +
//      (state.wasGiftSend ? '' : '. ${AppStrings.pleaseTapWhenSendGift}');
//
//  return Stack(
//    children: <Widget>[
//      Container(
//        width: double.infinity,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Text(text),
//            state.wasGiftSend
//                ? FittedBox()
//                : SizedBox(
//                    height: 15,
//                  ),
//            state.wasGiftSend ? FittedBox() : _buildButtons(state, dispatch),
//          ],
//        ),
//      ),
//      state.showProgressIndicator
//          ? Center(
//              child: CircularProgressIndicator(),
//            )
//          : FittedBox(),
//    ],
//  );
//}
//
//
//Widget _buildButtons(ResponseMessageState state, Dispatch dispatch) {
//  return FloatingActionButton.extended(
//    heroTag: 'button1',
//    onPressed: state.showProgressIndicator
//        ? null
//        : () => dispatch(ChatActionCreator.onSendGiftAction(state.id)),
//    label: Text(AppStrings.iSentGift),
//  );
//}
