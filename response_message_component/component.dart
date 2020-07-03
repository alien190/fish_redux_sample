import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ResponseMessageComponent extends Component<ResponseMessageState> {
  static const componentName = 'ResponseMessageComponent';

  ResponseMessageComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ResponseMessageState>(
              adapter: null,
              slots: <String, Dependent<ResponseMessageState>>{}),
        );
}
