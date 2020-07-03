import 'package:fish_redux/fish_redux.dart';

enum PaginationAction { onPagination }

class PaginationActionCreator {
  static Action onPaginationAction() {
    return const Action(PaginationAction.onPagination);
  }
}
