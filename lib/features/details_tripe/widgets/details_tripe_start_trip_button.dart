import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/features/trip/controllers/trip_controller.dart';
import 'package:hoooob_app/features/trip/screens/ride_requests_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class DetailsTripeStartTripButton extends StatelessWidget {
  final int routeId;

  const DetailsTripeStartTripButton({super.key, required this.routeId});

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
                buttonText: tripController.isTripBeingStarted(routeId)
                    ? 'starting_trip'.tr
                    : 'start_trip'.tr,
                onPressed: tripController.isTripBeingStarted(routeId)
                    ? null
                    : () => tripController.startTrip(routeId),
                fontSize: 20,
              ),
              Text(
                'start_trip_description'.tr,
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
}
