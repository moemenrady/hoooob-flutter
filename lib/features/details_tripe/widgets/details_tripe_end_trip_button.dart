import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/features/trip/controllers/trip_controller.dart';
import 'package:hoooob_app/features/trip/screens/ride_requests_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class DetailsTripeEndTripButton extends StatelessWidget {
  final int routeId;

  const DetailsTripeEndTripButton({super.key, required this.routeId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripeController>(
      builder: (tripController) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: MediaQuery.of(context).size.height * 0.01,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ButtonWidget(
                buttonText: tripController.isTripBeingEnded(routeId)
                    ? 'ending_trip'.tr
                    : 'end_trip'.tr,
                onPressed: tripController.isTripBeingEnded(routeId)
                    ? null
                    : () => _showEndTripConfirmationDialog(
                        context, tripController, routeId),
                fontSize: 20,
              ),
              Text(
                'end_trip_description'.tr,
                style: textRegular.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: Dimensions.fontSizeDefault),
              )
            ],
          ),
        );
      },
    );
  }

  void _showEndTripConfirmationDialog(
      BuildContext context, TripeController tripController, int routeId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.orange,
                size: 24,
              ),
              SizedBox(width: Dimensions.paddingSizeSmall),
              Text(
                'end_trip'.tr,
                style: textBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'are_you_sure_end_trip'.tr,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall),
              Text(
                'Trip ID: #$routeId',
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall),
              Text(
                'this_action_cannot_be_undone'.tr,
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'cancel'.tr,
                style: textMedium.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                tripController.endTrip(routeId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'end_trip'.tr,
                style: textMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
