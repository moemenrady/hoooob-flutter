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

FocusNode destinationLocationFocus = FocusNode();

class AddTripToStation extends StatelessWidget {
  const AddTripToStation({
    super.key,
    required this.size,
    required this.rideController,
    required this.locationController,
  });
  final Size size;
  final RideController rideController;
  final LocationController locationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.05,
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
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
                isReadOnly: rideController.rideDetails == null ? false : true,
                focusNode: destinationLocationFocus,
                controller: locationController.destinationLocationController,
                hint: 'destination'.tr,
                onChanged: (value) async {
                  return await Get.find<LocationController>().searchLocation(
                      context, value.trim(),
                      type: LocationType.to);
                },
                onTap: () {
                  if (rideController.rideDetails != null) {
                    showCustomSnackBar('your_ride_is_ongoing_complete'.tr,
                        isError: true);
                  }
                  print(locationController.pickPosition.latitude);
                })),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        locationController.selecting
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
                child: Image.asset(
                  Images.location,
                  width: size.width * 0.06,
                  height: size.height * 0.06,
                )),
      ]),
    );
  }
}
