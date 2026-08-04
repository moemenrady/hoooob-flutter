import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/custom_search_field.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/location/view/pick_map_screen.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/route_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';

FocusNode extraOneLocationFocus = FocusNode();

class AddTripeRestTripe extends StatefulWidget {
  const AddTripeRestTripe({super.key, required this.locationType});
final LocationType locationType;
  @override
  State<AddTripeRestTripe> createState() => _AddTripeRestTripeState();
}

class _AddTripeRestTripeState extends State<AddTripeRestTripe> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      locationController.restStopController = List.generate(
        locationController.addEntityList.length,
        (index) {
          if (locationController.restStopController.length > index) {
            return locationController.restStopController[index];
          } else {
            return TextEditingController();
          }
        },
      );
      return GetBuilder<RideController>(builder: (rideController) {
        return GetBuilder<AddTripeController>(builder: (addTripeController) {
          return Column(
            children: [
              ...List.generate(locationController.addEntityList.length,
                  (index) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).hintColor, width: 1),
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor.withOpacity(.25),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        child: Row(children: [
                          const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall),
                          Expanded(
                              child: CustomSearchField(

                                  isReadOnly:true,
                                  focusNode: extraOneLocationFocus,
                                  controller: locationController
                                      .extraRouteOneController,
                                  hint: widget.locationType==LocationType.extraOne? 'extra_route_one'.tr:'extra_route_two'.tr,
                                  onChanged: (value) async {
                                    return await Get.find<LocationController>()
                                        .searchLocation(context, value.trim(),
                                            type: widget.locationType);
                                  },
                                  onTap: () {
                                    if (rideController.rideDetails != null) {
                                      showCustomSnackBar(
                                          'your_ride_is_ongoing_complete'.tr,
                                          isError: true);
                                    }
                                    print(locationController
                                        .pickPosition.latitude);
                                  })),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          locationController.selecting
                              ? SpinKitCircle(
                                  color: Theme.of(context).cardColor,
                                  size: 40.0)
                              : InkWell(
                                  onTap: () {
                                    if (rideController.rideDetails != null) {
                                      showCustomSnackBar(
                                          'your_ride_is_ongoing_complete'.tr,
                                          isError: true);
                                    } else {
                                      RouteHelper.goPageAndHideTextField(
                                        context,
                                        PickMapScreen(
                                          type: widget.locationType,
                                          oldLocationExist: locationController
                                                      .pickPosition.latitude >
                                                  0
                                              ? true
                                              : false,
                                        ),
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    Images.location,
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                  )),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.redAccent[100]),
                      child: InkWell(
                        onTap: () {
                          locationController.addEntityList.removeAt(index);
                          locationController.addEntity--;
                          setState(() {});
                        },
                        // =>
                        //           locationController
                        //               .setExtraRoute(
                        //               remove: true),
                        child: Icon(Icons.clear, color: Colors.red),
                      ),
                    ),
                  ],
                );
              }),
            ],
          );
        });
      });
    });
  }
}
