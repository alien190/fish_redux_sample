import 'package:fish_redux/fish_redux.dart';

import '../../text_message_component/component.dart';
import '../../request_message_component/component.dart';
import '../../response_message_component/component.dart';
import '../../pagination_component/component.dart';
import '../../gift_message_component/component.dart';
import '../../feedback_message_component/component.dart';
import '../state.dart';

class MessageListAdapter extends SourceFlowAdapter<MessageListState> {
  MessageListAdapter()
      : super(
          pool: <String, Component<Object>>{
            TextMessageComponent.componentName: TextMessageComponent(),
            PaginationComponent.componentName: PaginationComponent(),
            RequestMessageComponent.componentName: RequestMessageComponent(),
            ResponseMessageComponent.componentName: ResponseMessageComponent(),
            GiftMessageComponent.componentName: GiftMessageComponent(),
            FeedbackMessageComponent.componentName: FeedbackMessageComponent(),
          },
        );
}
