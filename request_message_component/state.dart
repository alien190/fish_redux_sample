import 'package:fish_redux/fish_redux.dart';
import '../base_message_state.dart';

class RequestMessageState extends BaseMessageState
    implements Cloneable<RequestMessageState> {
  bool didResponseSend;
  bool showProgressIndicator;
  String id;
  String wishId;
  int giftCategoryIndex;

  RequestMessageState() : super(MessageType.request);

  @override
  RequestMessageState clone() {
    return RequestMessageState()
      ..timestamp = timestamp
      ..timestampStr = timestampStr
      ..isMyMessage = isMyMessage
      ..text = text
      ..didResponseSend = didResponseSend
      ..id = id
      ..showProgressIndicator = showProgressIndicator
      ..wishId = wishId
      ..giftCategoryIndex = giftCategoryIndex;
  }

  @override
  String toString() {
    return 'RequestMessageState{didResponseSend: $didResponseSend, showProgressIndicator: $showProgressIndicator, id: $id, wishId: $wishId, giftCategoryIndex: $giftCategoryIndex, isMyMessage: $isMyMessage}';
  }
}

RequestMessageState initState(Map<String, dynamic> args) {
  return RequestMessageState()..showProgressIndicator = false;
}
