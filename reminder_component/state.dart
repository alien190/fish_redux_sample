import 'package:fish_redux/fish_redux.dart';

class ReminderState implements Cloneable<ReminderState> {
  bool isNewItems;

  @override
  ReminderState clone() {
    return ReminderState()..isNewItems = isNewItems;
  }
}

ReminderState initState(Map<String, dynamic> args) {
  return ReminderState()..isNewItems = false;
}
