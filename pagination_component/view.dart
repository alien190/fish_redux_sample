import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PaginationState state, Dispatch dispatch, ViewService viewService) {
  print('build pagination component');

  if (state.isPaginationEnabled) {
    dispatch(PaginationActionCreator.onPaginationAction());
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
  return Container();
}
