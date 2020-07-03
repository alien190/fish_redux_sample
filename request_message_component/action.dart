import 'package:fish_redux/fish_redux.dart';

enum RequestMessageAction {
  onSendResponse,
  showProgressIndicator,
  hideProgressIndicator,
  //responseWasSend,
}

class RequestMessageActionCreator {
  static Action onSendResponseAction() {
    return const Action(RequestMessageAction.onSendResponse);
  }

  static Action showProgressIndicatorAction(String id) {
    return Action(RequestMessageAction.showProgressIndicator, payload: id);
  }

  static Action hideProgressIndicatorAction(String id) {
    return Action(RequestMessageAction.hideProgressIndicator, payload: id);
  }
//  static Action responseWasSendAction(String id) {
//    return Action(RequestMessageAction.responseWasSend, payload: id);
//  }
}
