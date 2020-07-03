import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GiftMessageState> buildReducer() {
  return asReducer(
    <Object, Reducer<GiftMessageState>>{
      GiftMessageAction.showProgressIndicator: _showProgressIndicator,
      GiftMessageAction.hideProgressIndicator: _hideProgressIndicator,
      //GiftMessageAction.feedbackWasSend: _feedbackWasSend,
    },
  );
}

GiftMessageState _showProgressIndicator(GiftMessageState state, Action action) {
  return _changeProgressIndicatorState(state, action, true);
}

GiftMessageState _hideProgressIndicator(GiftMessageState state, Action action) {
  return _changeProgressIndicatorState(state, action, false);
}

GiftMessageState _changeProgressIndicatorState(
    GiftMessageState state, Action action, bool showIndicator) {
  final GiftMessageState newState = state.clone();
  if (action.payload is String &&
      action.payload == state.id &&
      state.showProgressIndicator != showIndicator) {
    newState.showProgressIndicator = showIndicator;
  }
  return newState;
}

GiftMessageState _feedbackWasSend(GiftMessageState state, Action action) {
  final GiftMessageState newState = state.clone();
  if (action.payload is String && action.payload == state.id) {
    newState.showProgressIndicator = false;
    newState.wasFeedbackGet = true;
  }
  return newState;
}
