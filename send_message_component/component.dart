import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SendMessageComponent extends Component<SendMessageState> {
  static const String componentName = 'SendMessageComponent';

  SendMessageComponent()
      : super(
          shouldUpdate: (_, __) => true,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SendMessageState>(
              adapter: null, slots: <String, Dependent<SendMessageState>>{}),
        );
}
