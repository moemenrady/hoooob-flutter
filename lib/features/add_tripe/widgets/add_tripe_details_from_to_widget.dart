import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/custom_search_field.dart';
import 'package:hoooob_app/common_widgets/from_to_icon_widget.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_trip_from_station.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_trip_to_station.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_button_from_to_widget.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_rist_tripe.dart';
import 'package:hoooob_app/features/home/widgets/home_date_picker_time.dart';
import 'package:hoooob_app/features/home/widgets/to_text_widget.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/location/view/pick_map_screen.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/features/splash/controllers/config_controller.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/route_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class AddTripeDetailsFromToWidget extends StatefulWidget {
  const AddTripeDetailsFromToWidget({super.key});

  @override
  State<AddTripeDetailsFromToWidget> createState() =>
      _AddTripeDetailsFromToWidgetState();
}

FocusNode destinationLocationFocus = FocusNode();

class _AddTripeDetailsFromToWidgetState
    extends State<AddTripeDetailsFromToWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<AddTripeController>(builder: (addTripeController) {
      return GetBuilder<RideController>(builder: (rideController) {
        return GetBuilder<LocationController>(builder: (locationController) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Container(
              constraints: BoxConstraints(maxHeight: size.height * 0.7),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).hintColor.withValues(alpha: 0.2),
                    blurRadius: 25,
                    spreadRadius: 1,
                    offset: const Offset(1, 5),
                  )
                ],
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              Dimensions.paddingSizeSmall,
                              Dimensions.paddingSizeLarge,
                              0,
                              0,
                            ),
                            child: Column(children: [
                              FromToIconWidget(
                                heightLine: locationController.extraTwoRoute
                                    ? size.height * .100
                                    : locationController.extraOneRoute
                                        ? size.height * 0.18
                                        : size.height *
                                            (0.09 +
                                                locationController
                                                        .addEntityList.length *
                                                    0.09),
                              )
                            ]),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AddTripFromStation(
                                    size: size,
                                    rideController: rideController,
                                    locationController: locationController,
                                  ),
                                  ToTextWidget(),
                                  AddTripToStation(
                                    size: size,
                                    rideController: rideController,
                                    locationController: locationController,
                                  ),
                                  SizedBox(height: Dimensions.fontSizeLarge),

                                  AddTripeRestTripe(
                                    locationType: LocationType.extraOne,
                                  ),
                                  AddTripeRestTripe(
                                    locationType: LocationType.extraTwo,
                                  ),

                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // locationController
                                          //     .setExtraRoute(),
                                          if (locationController.addEntity ==0) {
                                            locationController.addEntity++;

                                            locationController.addEntityList
                                                .add(locationController
                                                    .addEntity);
                                            setState(() {});
                                          }
                                      
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? Theme.of(context).cardColor
                                                : Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(.50),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusDefault),
                                          ),
                                          child: Icon(Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.paddingSizeDefault,
                                      ),
                                      Text(
                                        'add_route'.tr,
                                        style: textRegular.copyWith(
                                          fontSize: Dimensions.fontSizeLarge,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: Dimensions.fontSizeLarge),
                                  Container(
                                    height: size.height * 0.05,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).hintColor,
                                        width: 1.0,
                                      ),
                                      color: Get.isDarkMode
                                          ? Theme.of(context).cardColor
                                          : Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDefault),
                                    ),
                                    child: Row(children: [
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Expanded(
                                          child: CustomSearchField(
                                              isReadOnly:true,
                                              // focusNode:
                                              //     destinationLocationFocus,
                                              controller: locationController
                                                  .addPassengersController,
                                              hint: 'add_passengers'.tr,
                                              onChanged: (value) async {
                                                return await Get.find<
                                                        LocationController>()
                                                    .searchLocation(
                                                        context, value.trim(),
                                                        type: LocationType.to);
                                              },
                                              onTap: () {
                                                addTripeController
                                                        .availableSeats =
                                                    locationController
                                                        .addPassengersController
                                                        .text;
                                                if (rideController
                                                        .rideDetails !=
                                                    null) {
                                                  showCustomSnackBar(
                                                      'your_ride_is_ongoing_complete'
                                                          .tr,
                                                      isError: true);
                                                }
                                              })),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeSmall),
                                      locationController.selecting
                                          ? SpinKitCircle(
                                              color:
                                                  Theme.of(context).cardColor,
                                              size: 40.0)
                                          : InkWell(
                                              onTap: () {
                                                if (rideController
                                                        .rideDetails !=
                                                    null) {
                                                  showCustomSnackBar(
                                                      'your_ride_is_ongoing_complete'
                                                          .tr,
                                                      isError: true);
                                                } else {
                                                  RouteHelper
                                                      .goPageAndHideTextField(
                                                    context,
                                                    PickMapScreen(
                                                      type: LocationType.to,
                                                      oldLocationExist:
                                                          locationController
                                                                      .pickPosition
                                                                      .latitude >
                                                                  0
                                                              ? true
                                                              : false,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Image.asset(
                                                Images.userIcon,
                                                width: size.width * 0.06,
                                                height: size.height * 0.06,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              )),
                                    ]),
                                  ),
                                  SizedBox(height: Dimensions.fontSizeLarge),
                                  Container(
                                    height: size.height * 0.05,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).hintColor,
                                        width: 1.0,
                                      ),
                                      color: Get.isDarkMode
                                          ? Theme.of(context).cardColor
                                          : Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDefault),
                                    ),
                                    child: Row(children: [
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Expanded(
                                          child: CustomSearchField(
                                              isReadOnly:
                                                  rideController.rideDetails ==
                                                          null
                                                      ? false
                                                      : true,
                                              // focusNode:
                                              // destinationLocationFocus,
                                              controller: locationController
                                                  .dateController,
                                              hint: 'date'.tr,
                                              onChanged: (value) async {
                                                return await Get.find<
                                                        LocationController>()
                                                    .searchLocation(
                                                        context, value.trim(),
                                                        type: LocationType.to);
                                              },
                                              onTap: () {
                                                // if (rideController
                                                //         .rideDetails !=
                                                //     null) {
                                                //   showCustomSnackBar(
                                                //       'your_ride_is_ongoing_complete'
                                                //           .tr,
                                                //       isError: true);
                                                // }
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) =>
                                                      HomeArabicDateTimePicker(),
                                                );
                                              })),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeSmall),
                                      locationController.selecting
                                          ? SpinKitCircle(
                                              color:
                                                  Theme.of(context).cardColor,
                                              size: 40.0)
                                          : InkWell(
                                              onTap: () {
                                                if (rideController
                                                        .rideDetails !=
                                                    null) {
                                                  showCustomSnackBar(
                                                      'your_ride_is_ongoing_complete'
                                                          .tr,
                                                      isError: true);
                                                } else {
                                                  RouteHelper
                                                      .goPageAndHideTextField(
                                                    context,
                                                    PickMapScreen(
                                                      type: LocationType.to,
                                                      oldLocationExist:
                                                          locationController
                                                                      .pickPosition
                                                                      .latitude >
                                                                  0
                                                              ? true
                                                              : false,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Image.asset(
                                                Images.calenderDIcon,
                                                width: size.width * 0.06,
                                                height: size.height * 0.06,
                                              )),
                                    ]),
                                  ),
                                  SizedBox(height: Dimensions.fontSizeLarge),
                                  SizedBox(
                                    width: locationController.extraTwoRoute
                                        ? 0
                                        : Dimensions.paddingSizeSmall,
                                  ),
                                  // if (locationController.extraOneRoute)
                                  //   Column(
                                  //     crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  //     children: [
                                  //       Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //           vertical: Dimensions
                                  //               .paddingSizeExtraSmall,
                                  //         ),
                                  //         child: Text(
                                  //           'to'.tr,
                                  //           style: textRegular.copyWith(
                                  //               fontWeight: FontWeight.w700,
                                  //               color: Colors.black),
                                  //         ),
                                  //       ),
                                  //
                                  //     ],
                                  //   ),
                                  // locationController.extraTwoRoute
                                  //     ? Column(
                                  //   crossAxisAlignment:
                                  //   CrossAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding:
                                  //       const EdgeInsets.symmetric(
                                  //         vertical: Dimensions
                                  //             .paddingSizeExtraSmall,
                                  //       ),
                                  //       child: Text(
                                  //         'to'.tr,
                                  //         style: textRegular.copyWith(
                                  //             fontWeight:
                                  //             FontWeight.w700,
                                  //             color: Colors.black),
                                  //       ),
                                  //     ),
                                  //     // Row(
                                  //     //   children: [
                                  //     //     Expanded(
                                  //     //       child: Container(
                                  //     //         height: 50,
                                  //     //         padding: const EdgeInsets
                                  //     //             .symmetric(
                                  //     //           horizontal: Dimensions
                                  //     //               .paddingSizeSmall,
                                  //     //         ),
                                  //     //         decoration: BoxDecoration(
                                  //     //           border: Border.all(
                                  //     //               width: 1,
                                  //     //               color: Theme.of(
                                  //     //                   context)
                                  //     //                   .hintColor),
                                  //     //           color: Get.isDarkMode
                                  //     //               ? Theme.of(context)
                                  //     //               .cardColor
                                  //     //               : Theme.of(context)
                                  //     //               .cardColor,
                                  //     //           borderRadius: BorderRadius
                                  //     //               .circular(Dimensions
                                  //     //               .radiusDefault),
                                  //     //         ),
                                  //     //         child: Row(children: [
                                  //     //           const SizedBox(
                                  //     //               width: Dimensions
                                  //     //                   .paddingSizeExtraSmall),
                                  //     //           Expanded(
                                  //     //               child:
                                  //     //               CustomSearchField(
                                  //     //                   isReadOnly: rideController.rideDetails ==
                                  //     //                       null
                                  //     //                       ? false
                                  //     //                       : true,
                                  //     //                   controller:
                                  //     //                   locationController
                                  //     //                       .extraRouteTwoController,
                                  //     //                   hint:
                                  //     //                   'extra_route_two'
                                  //     //                       .tr,
                                  //     //                   onChanged:
                                  //     //                       (value) async {
                                  //     //                     return await Get.find<
                                  //     //                         LocationController>()
                                  //     //                         .searchLocation(
                                  //     //                       context,
                                  //     //                       value,
                                  //     //                       type: LocationType
                                  //     //                           .extraTwo,
                                  //     //                     );
                                  //     //                   },
                                  //     //                   onTap: () {
                                  //     //                     if (rideController
                                  //     //                         .rideDetails !=
                                  //     //                         null) {
                                  //     //                       showCustomSnackBar(
                                  //     //                           'your_ride_is_ongoing_complete'
                                  //     //                               .tr,
                                  //     //                           isError:
                                  //     //                           true);
                                  //     //                     }
                                  //     //                   })),
                                  //     //           const SizedBox(
                                  //     //               width: Dimensions
                                  //     //                   .paddingSizeSmall),
                                  //     //           InkWell(
                                  //     //             onTap: () {
                                  //     //               if (rideController
                                  //     //                   .rideDetails !=
                                  //     //                   null) {
                                  //     //                 showCustomSnackBar(
                                  //     //                     'your_ride_is_ongoing_complete'
                                  //     //                         .tr,
                                  //     //                     isError:
                                  //     //                     true);
                                  //     //               } else {
                                  //     //                 RouteHelper
                                  //     //                     .goPageAndHideTextField(
                                  //     //                     context,
                                  //     //                     PickMapScreen(
                                  //     //                       type: LocationType
                                  //     //                           .extraTwo,
                                  //     //                       oldLocationExist: locationController.pickPosition.latitude >
                                  //     //                           0
                                  //     //                           ? true
                                  //     //                           : false,
                                  //     //                     ));
                                  //     //               }
                                  //     //             },
                                  //     //             child: Icon(
                                  //     //                 Icons.place,
                                  //     //                 color: Theme.of(
                                  //     //                     context)
                                  //     //                     .primaryColor),
                                  //     //           ),
                                  //     //         ]),
                                  //     //       ),
                                  //     //     ),
                                  //     //     const SizedBox(
                                  //     //       width: Dimensions
                                  //     //           .paddingSizeSmall,
                                  //     //     ),
                                  //     //     Container(
                                  //     //       width: 30,
                                  //     //       height: 30,
                                  //     //       decoration: BoxDecoration(
                                  //     //           borderRadius:
                                  //     //           BorderRadius.all(
                                  //     //               Radius.circular(
                                  //     //                   100)),
                                  //     //           color: Colors
                                  //     //               .redAccent[100]),
                                  //     //       child: InkWell(
                                  //     //         onTap: () =>
                                  //     //             locationController
                                  //     //                 .setExtraRoute(
                                  //     //                 remove: true),
                                  //     //         child: Icon(Icons.clear,
                                  //     //             color: Colors.red),
                                  //     //       ),
                                  //     //     ),
                                  //     //   ],
                                  //     // ),
                                  //   ],
                                  // )
                                  //     : const SizedBox(),
                                  // const SizedBox(
                                  //   height: Dimensions.paddingSize,
                                  // ),
                                  (!Get.find<ConfigController>()
                                              .config!
                                              .addIntermediatePoint! ||
                                          locationController.extraTwoRoute)
                                      ? const SizedBox()
                                      : Container(),

                                  // locationController.addEntrance
                                  //     ? SizedBox(
                                  //         width: 200,
                                  //         child: InputField(
                                  //           showSuffix: true,
                                  //           controller: locationController
                                  //               .entranceController,
                                  //           node: locationController
                                  //               .entranceNode,
                                  //           hint: 'enter_entrance'.tr,
                                  //         ),
                                  //       )
                                  //     : InkWell(
                                  //         onTap: () => locationController
                                  //             .setAddEntrance(),
                                  //         child: Row(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.end,
                                  //             children: [
                                  //               SizedBox(
                                  //                   height: 25,
                                  //                   child: Transform(
                                  //                     alignment:
                                  //                         Alignment.center,
                                  //                     transform: Get.find<
                                  //                                 LocalizationController>()
                                  //                             .isLtr
                                  //                         ? Matrix4
                                  //                             .rotationY(0)
                                  //                         : Matrix4
                                  //                             .rotationY(
                                  //                                 math.pi),
                                  //                     child: Image.asset(
                                  //                         Images
                                  //                             .curvedArrow),
                                  //                   )),
                                  //               const SizedBox(
                                  //                   width: Dimensions
                                  //                       .paddingSizeSmall),
                                  //               Row(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .end,
                                  //                   children: [
                                  //                     const Icon(Icons.add,
                                  //                         color:
                                  //                             Colors.white),
                                  //                     Padding(
                                  //                       padding: const EdgeInsets
                                  //                           .only(
                                  //                           top: Dimensions
                                  //                               .paddingSizeDefault),
                                  //                       child: Text(
                                  //                         'add_entrance'.tr,
                                  //                         style: textMedium
                                  //                             .copyWith(
                                  //                           color: Colors
                                  //                               .white
                                  //                               .withOpacity(
                                  //                                   .75),
                                  //                           fontSize: Dimensions
                                  //                               .fontSizeLarge,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ]),
                                  //             ]),
                                  //       ),
                                ]),
                          )),
                        ]),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(
                    //     Dimensions.paddingSizeExtraLarge,
                    //     Dimensions.paddingSizeSmall,
                    //     Dimensions.paddingSizeExtraLarge,
                    //     Dimensions.paddingSizeExtraLarge,
                    //   ),
                    //   child: Center(
                    //     child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           // Text(
                    //           //   'you_can_add_multiple_route_to'.tr,
                    //           //   style: textRegular.copyWith(
                    //           //     fontWeight: FontWeight.w600,
                    //           //     fontSize: Dimensions.fontSizeExtraLarge,
                    //           //     color: Colors.black,
                    //           //   ),
                    //           // ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 8.0),
                    //             child: Container(
                    //               width: size.width * 0.35 + 1,
                    //               height: size.height * 0.036,
                    //               decoration: BoxDecoration(
                    //                   color: Theme.of(context).primaryColor,
                    //                   borderRadius:
                    //                   BorderRadius.circular(30)),
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   Navigator.of(context).push(
                    //                       MaterialPageRoute(
                    //                           builder: (_) =>
                    //                               SearchTripsScreen()));
                    //                   if (Get.find<ConfigController>()
                    //                               .config!
                    //                               .maintenanceMode !=
                    //                           null &&
                    //                       Get.find<ConfigController>()
                    //                               .config!
                    //                               .maintenanceMode!
                    //                               .maintenanceStatus ==
                    //                           1 &&
                    //                       Get.find<ConfigController>()
                    //                               .config!
                    //                               .maintenanceMode!
                    //                               .selectedMaintenanceSystem!
                    //                               .userApp ==
                    //                           1) {
                    //                     showCustomSnackBar(
                    //                         'maintenance_mode_on_for_ride'.tr,
                    //                         isError: true);
                    //                   } else {
                    //                     if (locationController
                    //                                 .fromAddress ==
                    //                             null ||
                    //                         locationController
                    //                                 .fromAddress!.address ==
                    //                             null ||
                    //                         locationController.fromAddress!
                    //                             .address!.isEmpty) {
                    //                       showCustomSnackBar(
                    //                           'pickup_location_is_required'
                    //                               .tr);
                    //                       FocusScope.of(context).requestFocus(
                    //                           pickLocationFocus);
                    //                     } else if (locationController
                    //                         .pickupLocationController
                    //                         .text
                    //                         .isEmpty) {
                    //                       showCustomSnackBar(
                    //                           'pickup_location_is_required'
                    //                               .tr);
                    //                       FocusScope.of(context).requestFocus(
                    //                           pickLocationFocus);
                    //                     } else if (locationController
                    //                                 .toAddress ==
                    //                             null ||
                    //                         locationController
                    //                                 .toAddress!.address ==
                    //                             null ||
                    //                         locationController.toAddress!
                    //                             .address!.isEmpty) {
                    //                       showCustomSnackBar(
                    //                           'destination_location_is_required'
                    //                               .tr);
                    //                       FocusScope.of(context).requestFocus(
                    //                           destinationLocationFocus);
                    //                     } else if (locationController
                    //                         .destinationLocationController
                    //                         .text
                    //                         .isEmpty) {
                    //                       showCustomSnackBar(
                    //                           'destination_location_is_required'
                    //                               .tr);
                    //                       FocusScope.of(context).requestFocus(
                    //                           destinationLocationFocus);
                    //                     } else {
                    //                       rideController
                    //                           .getEstimatedFare(false)
                    //                           .then((value) {
                    //                         if (value.statusCode == 200) {
                    //                           Get.find<LocationController>()
                    //                               .initAddLocationData();
                    //                           Get.to(() => const MapScreen(
                    //                                 fromScreen:
                    //                                     MapScreenType.ride,
                    //                                 isShowCurrentPosition:
                    //                                     false,
                    //                               ));
                    //                           Get.find<RideController>()
                    //                               .updateRideCurrentState(
                    //                                   RideState.initial);
                    //                         }
                    //                       });
                    //                       // Get.find<RideController>().getDirection();
                    //                     }
                    //                   }
                    //                 },
                    //                 child: rideController.loading
                    //                     ? SpinKitCircle(
                    //                     color:
                    //                     Theme.of(context).cardColor,
                    //                     size: 40.0)
                    //                     : Center(
                    //                   child: Text(
                    //                     'search'.tr,
                    //                     style: textRegular.copyWith(
                    //                       fontSize: Dimensions
                    //                           .fontSizeDefault,
                    //                       fontWeight: FontWeight.w700,
                    //                       color: Colors.white,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ]),
                    //   ),
                    // ),
                    AddTripeButtonFromToWidget(),
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}
