import 'package:fish_redux/fish_redux.dart';

import '../base_message_state.dart';

class TextMessageState extends BaseMessageState
    implements Cloneable<TextMessageState> {
  TextMessageState() : super(MessageType.text);

  @override
  TextMessageState clone() {
    return super.clone();
  }
}

TextMessageState initState(Map<String, dynamic> args) {
  return TextMessageState()
    ..timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
}
