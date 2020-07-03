import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TextMessageComponent extends Component<TextMessageState> {
  static const String componentName = 'TextMessageComponent';
  
  TextMessageComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TextMessageState>(
                adapter: null,
                slots: <String, Dependent<TextMessageState>>{
                }),);

}
