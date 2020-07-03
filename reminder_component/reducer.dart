import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ReminderState> buildReducer() {
  return asReducer(
    <Object, Reducer<ReminderState>>{
      ReminderAction.action: _onAction,
    },
  );
}

ReminderState _onAction(ReminderState state, Action action) {
  final ReminderState newState = state.clone();
  return newState;
}
