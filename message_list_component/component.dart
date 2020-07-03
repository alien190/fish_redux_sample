import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

import 'message_list_adapter/adapter.dart';

class MessageListComponent extends Component<MessageListState> {
  static const componentName = 'MessageListComponent';

  MessageListComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<MessageListState>(
              adapter: NoneConn<MessageListState>() + MessageListAdapter(),
              slots: <String, Dependent<MessageListState>>{}),
        );
}

class MessageColumnComponent extends Component<MessageListState> {
  static const componentName = 'MessageColumnComponent';

  MessageColumnComponent()
      : super(
          view: buildColumnView,
          dependencies: Dependencies<MessageListState>(
              adapter: NoneConn<MessageListState>() + MessageListAdapter(),
              slots: <String, Dependent<MessageListState>>{}),
        );
}
