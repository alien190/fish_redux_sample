import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RequestMessageState> buildReducer() {
  return asReducer(
    <Object, Reducer<RequestMessageState>>{
      RequestMessageAction.showProgressIndicator: _showProgressIndicator,
      RequestMessageAction.hideProgressIndicator: _hideProgressIndicator,
      //RequestMessageAction.responseWasSend: _responseSent,
    },
  );
}

RequestMessageState _showProgressIndicator(
    RequestMessageState state, Action action) {
  return _changeProgressIndicatorState(state, action, true);
}

RequestMessageState _hideProgressIndicator(
    RequestMessageState state, Action action) {
  return _changeProgressIndicatorState(state, action, false);
}

RequestMessageState _changeProgressIndicatorState(
    RequestMessageState state, Action action, bool showIndicator) {
  final RequestMessageState newState = state.clone();
  if (action.payload is String &&
      action.payload == state.id &&
      state.showProgressIndicator != showIndicator) {
    newState.showProgressIndicator = showIndicator;
  }
  return newState;
}

RequestMessageState _responseSent(RequestMessageState state, Action action) {
  final RequestMessageState newState = state.clone();
  if (action.payload is String && action.payload == state.id) {
    newState.showProgressIndicator = false;
    newState.didResponseSend = true;
  }
  return newState;
}
