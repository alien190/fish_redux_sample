import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Effect<RequestMessageState> buildEffect() {
  return combineEffects(<Object, Effect<RequestMessageState>>{});
}
