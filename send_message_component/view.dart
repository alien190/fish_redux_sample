import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:wer_wichtelt/src/common/common.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SendMessageState state, Dispatch dispatch, ViewService viewService) {
  print(state.canSubmit);
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.grayColor))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.writeMessage,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.redColor,
                    ),
                  ),
                ),
                maxLines: null,
                onChanged: (_) =>
                    dispatch(SendMessageActionCreator.changeAction()),
                controller: state.messageController,
                focusNode: state.focusMessage,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: AppColors.redColor,
            onPressed: state.canSubmit
                ? () => dispatch(SendMessageActionCreator.onSendAction())
                : null,
          )
        ],
      ),
    ),
  );
}
