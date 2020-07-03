import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wer_wichtelt/src/ui/chat_page/action.dart';
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import 'state.dart';
import 'page.dart';
import 'reminder_component/component.dart';
import 'send_message_component/component.dart';

Widget buildView(ChatState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      key: state.scaffoldKey,
      //backgroundColor: Colors.white,
      appBar: _buildAppBar(state, dispatch, viewService),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: _buildList(state, viewService),
                onTap: () => dispatch(ChatActionCreator.onHideKeyboardAction()),
              ),
            ),
            viewService.buildComponent(ChatPage.actionMessagesComponent),
            state.isReadOnly
                ? FittedBox()
                : viewService.buildComponent(SendMessageComponent.componentName),
          ],
        ),
      ),
  );
}

Stack _buildList(ChatState state, ViewService viewService) {
  final Key forwardListKey = UniqueKey();
  return Stack(
    children: <Widget>[
      Scrollable(
        controller: state.scrollController,
        viewportBuilder: (BuildContext context, ViewportOffset offset) {
          return Viewport(
            offset: offset,
            center: forwardListKey,
            anchor: 1.0,
            slivers: [
              viewService.buildComponent(ChatPage.paginatedMessagesComponent),
              SliverPadding(
                key: forwardListKey,
                padding: EdgeInsets.all(0),
                sliver:
                    viewService.buildComponent(ChatPage.liveMessagesComponent),
              ),
            ],
          );
        },
      ),
      viewService.buildComponent(ReminderComponent.componentName),
    ],
  );
}

AppBar _buildAppBar(
    ChatState state, Dispatch dispatch, ViewService viewService) {
  final List<Widget> actions = [];

  if (!state.isReadOnly) {
    actions.add(_buildPopupMenu(dispatch, viewService));
  }

  return AppBar(
    actions: actions,
    automaticallyImplyLeading: true,
    backgroundColor: AppColors.lightGrayColor,
    elevation: 0,
    title: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'chat_${state.anotherUserId}',
            child: CircleAvatar(
              backgroundImage: MemoryImage(state.anotherUserPicture),
            ),
          ),
        ),
        Text(state.anotherUserName),
        //, style: TextStyle(color: Colors.black),),
      ],
    ),
  );
}

Widget _buildPopupMenu(Dispatch dispatch, ViewService viewService) {
  return PopupMenuButton<int>(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Text(AppStrings.complain),
          value: 0,
        )
      ];
    },
    onSelected: (int index) {
      if (index == 0) {
        showAlertDialog(
          context: viewService.context,
          title: AppStrings.complain,
          text: AppStrings.hideChatAndSendComplaint,
          onOkAction: () => dispatch(ChatActionCreator.onAddComplaintAction()),
        );
      }
    },
  );
}
