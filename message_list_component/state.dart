import 'package:fish_redux/fish_redux.dart';

export '../text_message_component/state.dart';

import '../pagination_component/state.dart';
import '../pagination_component/component.dart';
import '../text_message_component/component.dart';
import '../request_message_component/component.dart';
import '../response_message_component/component.dart';
import '../gift_message_component/component.dart';
import '../feedback_message_component/component.dart';
import '../base_message_state.dart';

class MessageListState extends MutableSource
    implements Cloneable<MessageListState> {
  List<BaseMessageState> messages;
  bool isPaginationEnabled;
  bool isBuildNotificationEnable;

  @override
  MessageListState clone() {
    return MessageListState()
      ..messages = messages
      ..isPaginationEnabled = isPaginationEnabled;
  }

  @override
  void setItemData(int index, Object data) {
    if (index < itemCount - 1) {
      messages[index] = data;
    }
  }

  @override
  Object getItemData(int index) {
    return index < itemCount - 1
        ? messages[index]
        : (PaginationState()..isPaginationEnabled = isPaginationEnabled);
  }

  @override
  String getItemType(int index) {
    if (index == itemCount - 1) {
      return PaginationComponent.componentName;
    }
    switch (messages[index].messageType) {
      case MessageType.text:
        return TextMessageComponent.componentName;
      case MessageType.request:
        return RequestMessageComponent.componentName;
      case MessageType.response:
        return ResponseMessageComponent.componentName;
      case MessageType.gift:
        return GiftMessageComponent.componentName;
      case MessageType.feedback:
        return FeedbackMessageComponent.componentName;
    }
    return TextMessageComponent.componentName;
  }

  @override
  int get itemCount => (messages?.length ?? 0) + 1;
}

MessageListState initState(Map<String, dynamic> args) {
  return MessageListState()
    ..messages = []
    ..isPaginationEnabled = false
    ..isBuildNotificationEnable = false;
}
