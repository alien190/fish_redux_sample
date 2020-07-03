import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:wer_wichtelt/src/common/common.dart';
import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import 'state.dart';

Widget buildView(
    TextMessageState state, Dispatch dispatch, ViewService viewService) {
  return buildChatMessage(state: state, text: state.text);
}
