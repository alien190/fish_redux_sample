import 'package:fish_redux/fish_redux.dart';

enum GiftMessageAction {
  showProgressIndicator,
  hideProgressIndicator,
  //feedbackWasSend,
}

class GiftMessageActionCreator {
  static Action showProgressIndicatorAction(String id) {
    return Action(GiftMessageAction.showProgressIndicator, payload: id);
  }

  static Action hideProgressIndicatorAction(String id) {
    return Action(GiftMessageAction.hideProgressIndicator, payload: id);
  }

//  static Action feedbackWasSendAction(String id) {
//    return Action(GiftMessageAction.feedbackWasSend, payload: id);
//  }
}
