import 'package:fish_redux/fish_redux.dart';

enum TextMessageAction { onFetchPaginated }

class TextMessageActionCreator {
  static Action onFetchPaginatedAction() {
    return const Action(TextMessageAction.onFetchPaginated);
  }
}
