import 'package:fish_redux/fish_redux.dart';

enum SendMessageAction { change, onSend, clearInput }

class SendMessageActionCreator {
  static Action changeAction() {
    return const Action(SendMessageAction.change);
  }

  static Action onSendAction() {
    return const Action(SendMessageAction.onSend);
  }

  static Action clearInputAction() {
    return const Action(SendMessageAction.clearInput);
  }
}
