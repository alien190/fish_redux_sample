import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ReminderState> buildEffect() {
  return combineEffects(<Object, Effect<ReminderState>>{
    ReminderAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ReminderState> ctx) {
}
