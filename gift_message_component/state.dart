import 'package:fish_redux/fish_redux.dart';
import '../base_message_state.dart';

class GiftMessageState extends BaseMessageState
    implements Cloneable<GiftMessageState> {
  bool wasFeedbackGet;
  bool showProgressIndicator;
  String id;
  int giftCategoryIndex;

  GiftMessageState() : super(MessageType.gift);

  @override
  GiftMessageState clone() {
    return GiftMessageState()
      ..timestamp = timestamp
      ..timestampStr = timestampStr
      ..isMyMessage = isMyMessage
      ..text = text
      ..wasFeedbackGet = wasFeedbackGet
      ..showProgressIndicator = showProgressIndicator
      ..id = id
      ..giftCategoryIndex = giftCategoryIndex;
  }
}

GiftMessageState initState(Map<String, dynamic> args) {
  return GiftMessageState();
}
