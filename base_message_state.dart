import 'package:wer_wichtelt/src/models/models.dart' as models;
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';
import 'text_message_component/state.dart';
import 'request_message_component/state.dart';
import 'response_message_component/state.dart';
import 'gift_message_component/state.dart';
import 'feedback_message_component/state.dart';

enum MessageType { text, request, response, gift, feedback }

class BaseMessageState {
  int timestamp;
  String timestampStr;
  bool isMyMessage;
  String text;
  final MessageType messageType;

  BaseMessageState(this.messageType);

  BaseMessageState clone() {
    return BaseMessageState(messageType)
      ..timestamp = timestamp
      ..timestampStr = timestampStr
      ..isMyMessage = isMyMessage
      ..text = text;
  }
}

class MessageStateFactory {
  static BaseMessageState fromModel(
      models.ChatBaseMessageModel model, String anotherUserId) {
    switch (model.messageType) {
      case models.MessageType.text:
        {
          final message = model as models.ChatTextMessageModel;
          return TextMessageState()
            ..timestamp = message.timestamp
            ..timestampStr = getHumanDate(message.timestamp)
            ..isMyMessage = message.userId != anotherUserId
            ..text = message.text ?? '';
        }
      case models.MessageType.request:
        {
          final message = model as models.ChatRequestMessageModel;
          return RequestMessageState()
            ..timestamp = message.timestamp
            ..timestampStr = getHumanDate(message.timestamp)
            ..isMyMessage = message.userId != anotherUserId
            ..text = message.text ?? ''
            ..didResponseSend = message.didResponseSend
            ..id = message.id
            ..showProgressIndicator = false
            ..wishId = message.wishId
            ..giftCategoryIndex = message.giftCategoryIndex;
        }
      case models.MessageType.response:
        {
          final message = model as models.ChatResponseMessageModel;
          return ResponseMessageState()
            ..isAccepted = message.isAccepted
            ..timestamp = message.timestamp
            ..timestampStr = getHumanDate(message.timestamp)
            ..isMyMessage = message.userId != anotherUserId
            ..text = message.text ?? ''
            ..showProgressIndicator = false
            ..wasGiftSend = message.wasGiftSend
            ..id = message.id
            ..giftCategoryIndex = message.giftCategoryIndex;
        }

      case models.MessageType.gift:
        {
          final message = model as models.ChatGiftMessageModel;
          return GiftMessageState()
            ..timestamp = message.timestamp
            ..timestampStr = getHumanDate(message.timestamp)
            ..isMyMessage = message.userId != anotherUserId
            ..text = message.text ?? ''
            ..showProgressIndicator = false
            ..wasFeedbackGet = message.wasFeedbackGet
            ..id = message.id
            ..giftCategoryIndex = message.giftCategoryIndex;
        }
      case models.MessageType.feedback:
        {
          final message = model as models.ChatFeedbackMessageModel;
          return FeedbackMessageState()
            ..timestamp = message.timestamp
            ..timestampStr = getHumanDate(message.timestamp)
            ..isMyMessage = message.userId != anotherUserId
            ..text = message.text ?? ''
            ..comment = message.comment
            ..overallRate = message.overallRate
            ..originalityRate = message.originalityRate
            ..satisfactionRate = message.satisfactionRate
            ..deliveryRate = message.deliveryRate
            ..pictureUrl = message.pictureUrl
            ..toUserId = message.toUserId
            ..toName = message.toName
            ..fromUserId = message.fromUserId
            ..fromName = message.fromName
            ..giftCategoryIndex = message.giftCategoryIndex;
        }
    }
    return null;
  }
}
