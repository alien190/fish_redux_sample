import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TextMessageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TextMessageState>>{},
  );
}
