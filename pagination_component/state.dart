import 'package:fish_redux/fish_redux.dart';

class PaginationState implements Cloneable<PaginationState> {
  bool isPaginationEnabled;

  @override
  PaginationState clone() {
    return PaginationState()..isPaginationEnabled = isPaginationEnabled;
  }
}

PaginationState initState(Map<String, dynamic> args) {
  return PaginationState()..isPaginationEnabled = false;
}
