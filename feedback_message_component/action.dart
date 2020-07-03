import 'package:fish_redux/fish_redux.dart';


enum FeedbackMessageAction { action }

class FeedbackMessageActionCreator {
  static Action onAction() {
    return const Action(FeedbackMessageAction.action);
  }
}
