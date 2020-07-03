import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PaginationComponent extends Component<PaginationState> {
  static const String componentName = 'PaginationComponent';
  PaginationComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PaginationState>(
              adapter: null, slots: <String, Dependent<PaginationState>>{}),
        );
}
