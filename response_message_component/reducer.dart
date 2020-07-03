import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ResponseMessageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ResponseMessageState>>{
      ResponseMessageAction.showProgressIndicator: _showProgressIndicator,
      ResponseMessageAction.hideProgressIndicator: _hideProgressIndicator,
      //ResponseMessageAction.giftWasSend: _giftSend,
    },
  );
}

ResponseMessageState _showProgressIndicator(
    ResponseMessageState state, Action action) {
  return _changeProgressIndicatorState(state, action, true);
}

ResponseMessageState _hideProgressIndicator(
    ResponseMessageState state, Action action) {
  return _changeProgressIndicatorState(state, action, false);
}

ResponseMessageState _changeProgressIndicatorState(
    ResponseMessageState state, Action action, bool showIndicator) {
  final ResponseMessageState newState = state.clone();
  if (action.payload is String &&
      action.payload == state.id &&
      state.showProgressIndicator != showIndicator) {
    newState.showProgressIndicator = showIndicator;
  }
  return newState;
}

ResponseMessageState _giftSend(ResponseMessageState state, Action action) {
  final ResponseMessageState newState = state.clone();
  if (action.payload is String && action.payload == state.id) {
    newState.showProgressIndicator = false;
    newState.wasGiftSend = true;
  }
  return newState;
}
