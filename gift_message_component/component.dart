import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GiftMessageComponent extends Component<GiftMessageState> {
  static const componentName = 'GiftMessageComponent';

  GiftMessageComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GiftMessageState>(
              adapter: null, slots: <String, Dependent<GiftMessageState>>{}),
        );
}
