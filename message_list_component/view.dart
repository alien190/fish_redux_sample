import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import 'state.dart';
import '../action.dart';

Widget buildView(
    MessageListState state, Dispatch dispatch, ViewService viewService) {
  if (state.isBuildNotificationEnable) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dispatch(ChatActionCreator.onListBuildNotificationAction());
    });
  }

  final ListAdapter adapter = viewService.buildAdapter();
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      adapter.itemBuilder,
      childCount: adapter.itemCount,
    ),
  );
}

Widget buildColumnView(
    MessageListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  final List<Widget> widgets = [];

  for (int i = 0; i < adapter.itemCount - 1; i++) {
    widgets.add(adapter.itemBuilder(viewService.context, i));
  }

  if (widgets.isNotEmpty) {
    widgets.insert(
      0,
      Divider(
        color: AppColors.grayColor,
      ),
    );
  }
  return Column(children: widgets);
}
