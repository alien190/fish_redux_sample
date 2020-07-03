import 'package:fish_redux/fish_redux.dart';

import '../base_message_state.dart';

class FeedbackMessageState extends BaseMessageState
    implements Cloneable<FeedbackMessageState> {
  String fromName;
  String fromUserId;
  String toName;
  String toUserId;
  String pictureUrl;
  String comment;
  double overallRate;
  int originalityRate;
  int deliveryRate;
  int satisfactionRate;
  int giftCategoryIndex;

  @override
  FeedbackMessageState clone() {
    return FeedbackMessageState()
      ..timestamp = timestamp
      ..timestampStr = timestampStr
      ..isMyMessage = isMyMessage
      ..text = text
      ..fromName = fromName
      ..fromUserId = fromUserId
      ..toName = toName
      ..toUserId = toUserId
      ..pictureUrl = pictureUrl
      ..comment = comment
      ..overallRate = overallRate
      ..originalityRate = originalityRate
      ..deliveryRate = deliveryRate
      ..satisfactionRate = satisfactionRate
      ..giftCategoryIndex = giftCategoryIndex;
  }

  FeedbackMessageState() : super(MessageType.feedback);
}

FeedbackMessageState initState(Map<String, dynamic> args) {
  return FeedbackMessageState();
}
