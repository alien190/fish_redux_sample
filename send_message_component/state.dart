import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

class SendMessageState implements Cloneable<SendMessageState> {
  TextEditingController messageController;
  FocusNode focusMessage;
  bool canSubmit;
  String chatRoomId;
  String message;

  @override
  SendMessageState clone() {
    return SendMessageState()
      ..messageController = messageController
      ..focusMessage = focusMessage
      ..canSubmit = canSubmit
      ..chatRoomId = chatRoomId
      ..message = message;
  }
}

SendMessageState initState(Map<String, dynamic> args) {
  return SendMessageState()
    ..messageController = TextEditingController()
    ..focusMessage = FocusNode()
    ..canSubmit = false
    ..chatRoomId = ''
    ..message = '';
}
