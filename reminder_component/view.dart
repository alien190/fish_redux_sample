import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:wer_wichtelt/src/common/common.dart';

import 'state.dart';

Widget buildView(
    ReminderState state, Dispatch dispatch, ViewService viewService) {
  return state.isNewItems
      ? Align(
          alignment: Alignment.bottomCenter,
          child: ActionChip(
            label: Text(
              AppStrings.newMessages,
              style: AppTextStyles.myChatMessageText,
            ),
            onPressed: () {},
            avatar: Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
            backgroundColor: AppColors.redColor,
          ),
        )
      : const FittedBox();
}
