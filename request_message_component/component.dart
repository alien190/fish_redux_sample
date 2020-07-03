import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RequestMessageComponent extends Component<RequestMessageState> {
  static const componentName = 'RequestMessageComponent';

  RequestMessageComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RequestMessageState>(
              adapter: null, slots: <String, Dependent<RequestMessageState>>{}),
        );
}
