import 'package:fish_redux/fish_redux.dart';

import '../../ui_common/ui_common.dart';
import 'action.dart';
import 'state.dart';

Reducer<SendMessageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SendMessageState>>{
      SendMessageAction.change: _changeAction,
      SendMessageAction.clearInput: _clearInput,
    },
  );
}

SendMessageState _changeAction(SendMessageState state, Action action) {
  final SendMessageState newState = state.clone();
  final String message = state.messageController.text;
  newState.message = cropSpaces(message);
  newState.canSubmit = newState.message.length > 0;
  print('|${newState.message}|');
  return newState;
}

SendMessageState _clearInput(SendMessageState state, Action action) {
  final SendMessageState newState = state.clone();
  newState.messageController.clear();
  newState.message = '';
  return newState;
}
