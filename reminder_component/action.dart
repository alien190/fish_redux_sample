import 'package:fish_redux/fish_redux.dart';

enum ReminderAction { action }

class ReminderActionCreator {
  static Action onAction() {
    return const Action(ReminderAction.action);
  }
}
