import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:wer_wichtelt/src/ui/ui_common/ui_common.dart';

import 'state.dart';

Widget buildView(
    FeedbackMessageState state, Dispatch dispatch, ViewService viewService) {
  Widget image;
  if (state.pictureUrl != null && state.pictureUrl.isNotEmpty) {
    image = AspectRatio(
      child: CachedNetworkImage(
        imageUrl: state.pictureUrl,
        fit: BoxFit.cover,
      ),
      aspectRatio: 1,
    );
  } else {
    image = FittedBox();
  }

  final Widget body = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        state.isMyMessage
            ? '${AppStrings.youSentFeedback} - ${getCategoryPriceStr(state.giftCategoryIndex)}'
            : '${AppStrings.youReceiveFeedback} - ${getCategoryPriceStr(state.giftCategoryIndex)}',
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 8.0,
      ),
      image,
      _buildRate(state),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(child: Text(state.comment)),
          ],
        ),
      ),
    ],
  );

  return buildChatActionMessage(
    state: state,
    body: body,
  );
}

Widget _buildRate(FeedbackMessageState state) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${AppStrings.overallRate}: ${formatUserRating(state.overallRate)}'),
        const SizedBox(height: 8.0),
        Text(AppStrings.originalityOfTheGift),
        buildRateStars(state.originalityRate, null),
        const SizedBox(height: 8.0),
        Text(AppStrings.speedOfDelivery),
        buildRateStars(state.deliveryRate, null),
        const SizedBox(height: 8.0),
        Text(AppStrings.overallSatisfaction),
        buildRateStars(state.satisfactionRate, null),
      ],
    ),
  );
}
