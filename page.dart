import 'dart:typed_data';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Page;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'message_list_component/component.dart';
import 'reminder_component/component.dart';
import 'send_message_component/component.dart';

class ChatPage extends Page<ChatState, Map<String, dynamic>> {
  static const String pageName = 'chatPage';
  static const String liveMessagesComponent = 'liveMessagesComponent';
  static const String paginatedMessagesComponent = 'paginatedMessagesComponent';
  static const String actionMessagesComponent = 'actionMessagesComponent';

  ChatPage()
      : super(
          shouldUpdate: _shouldUpdate,
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies:
              Dependencies<ChatState>(slots: <String, Dependent<ChatState>>{
            liveMessagesComponent:
                LiveMessagesConnector() + MessageListComponent(),
            paginatedMessagesComponent:
                PaginatedMessageConnector() + MessageListComponent(),
            actionMessagesComponent:
                ActionsMessageConnector() + MessageColumnComponent(),
            ReminderComponent.componentName:
                ReminderConnector() + ReminderComponent(),
            SendMessageComponent.componentName:
                SendMessageConnector() + SendMessageComponent(),
          }),
          middleware: <Middleware<ChatState>>[],
        );

  static push({
    @required BuildContext context,
    @required String chatRoomId,
    @required String anotherUserId,
    @required String anotherUserName,
    @required Uint8List anotherUserPicture,
    bool isReadOnly = false,
  }) {
    final Map<String, dynamic> arguments = {
      ChatState.chatRoomIdKey: chatRoomId,
      ChatState.anotherUserIdKey: anotherUserId,
      ChatState.anotherUserNameKey: anotherUserName,
      ChatState.anotherUserPictureKey: anotherUserPicture,
      ChatState.isReadOnlyKey: isReadOnly,
    };

    Navigator.of(context).pushNamed(ChatPage.pageName, arguments: arguments);
  }
}

bool _shouldUpdate(ChatState old, ChatState now) => false;
