import 'package:fish_redux/fish_redux.dart';

import '../base_message_state.dart';

class ResponseMessageState extends BaseMessageState
    implements Cloneable<ResponseMessageState> {
  bool isAccepted;
  bool wasGiftSend;
  bool showProgressIndicator;
  String id;
  int giftCategoryIndex;

  @override
  ResponseMessageState clone() {
    return ResponseMessageState()
      ..timestamp = timestamp
      ..timestampStr = timestampStr
      ..isMyMessage = isMyMessage
      ..text = text
      ..isAccepted = isAccepted
      ..wasGiftSend = wasGiftSend
      ..showProgressIndicator = showProgressIndicator
      ..id = id
      ..giftCategoryIndex = giftCategoryIndex;
  }

  ResponseMessageState() : super(MessageType.response);
}

ResponseMessageState initState(Map<String, dynamic> args) {
  return ResponseMessageState();
}
