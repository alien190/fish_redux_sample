import 'package:fish_redux/fish_redux.dart';

enum ResponseMessageAction {
  showProgressIndicator,
  hideProgressIndicator,
  //giftWasSend,
}

class ResponseMessageActionCreator {
  static Action showProgressIndicatorAction(String id) {
    return Action(ResponseMessageAction.showProgressIndicator, payload: id);
  }

  static Action hideProgressIndicatorAction(String id) {
    return Action(ResponseMessageAction.hideProgressIndicator, payload: id);
  }

//  static Action giftWasSendAction(String id) {
//    return Action(ResponseMessageAction.giftWasSend, payload: id);
//  }
}
