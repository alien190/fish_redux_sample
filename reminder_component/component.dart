import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ReminderComponent extends Component<ReminderState> {
  static const String componentName = 'reminderComponent';

  ReminderComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ReminderState>(
              adapter: null, slots: <String, Dependent<ReminderState>>{}),
        );
}
