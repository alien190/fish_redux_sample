import 'package:fish_redux/fish_redux.dart';

import 'package:wer_wichtelt/src/resources/resources.dart';
import 'action.dart';
import 'state.dart';

final Repository _repository = MainRepository();

Effect<SendMessageState> buildEffect() {
  return combineEffects(<Object, Effect<SendMessageState>>{
    SendMessageAction.onSend: _onSend,
    Lifecycle.dispose: _onDispose,
  });
}

void _onSend(Action action, Context<SendMessageState> ctx) {
  print('onSend: ${ctx.state.message}');
  _repository.sendChatMessage(ctx.state.message, ctx.state.chatRoomId);
  ctx.state.messageController.clear();
  ctx.dispatch(SendMessageActionCreator.clearInputAction());
}

void _onDispose(Action action, Context<SendMessageState> ctx) {
  ctx.dispatch(SendMessageActionCreator.clearInputAction());
}
