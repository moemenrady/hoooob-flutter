import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/custom_search_field.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/location/view/pick_map_screen.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/route_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';

FocusNode pickLocationFocus = FocusNode();

class ToStationWidget extends StatelessWidget {
  const ToStationWidget({
    super.key,
    required this.size,
    required this.rideController,
    required this.locationController,
  });
  final RideController rideController;
  final LocationController locationController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return locationController.selecting
        ? SpinKitCircle(color: Theme.of(context).cardColor, size: 40.0)
        : InkWell(
            onTap: () {
              if (rideController.rideDetails != null) {
                showCustomSnackBar('your_ride_is_ongoing_complete'.tr,
                    isError: true);
              } else {
                RouteHelper.goPageAndHideTextField(
                  context,
                  PickMapScreen(
                    type: LocationType.to,
                    oldLocationExist:
                        locationController.pickPosition.latitude > 0
                            ? true
                            : false,
                  ),
                );
              }
            },
            child: Container(
              height: size.height * 0.05 + 2,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).hintColor,
                  width: 1.0,
                ),
                color: Get.isDarkMode
                    ? Theme.of(context).cardColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              child: Row(children: [
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Expanded(
                    child: CustomSearchField(
                        isReadOnly: true,
                        // focusNode:
                        //     destinationLocationFocus,
                        controller:
                            locationController.destinationLocationController,
                        hint: 'destination'.tr,
                        onChanged: (value) async {
                          return await Get.find<LocationController>()
                              .searchLocation(context, value.trim(),
                                  type: LocationType.to);
                        },
                        onTap: () {
                          if (rideController.rideDetails != null) {
                            showCustomSnackBar(
                                'your_ride_is_ongoing_complete'.tr,
                                isError: true);
                          }
                        })),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Image.asset(
                  Images.location,
                  width: size.width * 0.06,
                  height: size.height * 0.06,
                )
              ]),
            ),
          );
  }
}
