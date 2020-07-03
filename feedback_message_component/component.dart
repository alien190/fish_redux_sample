import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FeedbackMessageComponent extends Component<FeedbackMessageState> {
  static const String componentName = 'FeedbackMessageComponent';

  FeedbackMessageComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FeedbackMessageState>(
              adapter: null,
              slots: <String, Dependent<FeedbackMessageState>>{}),
        );
}
