import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:hoooob_app/common_widgets/custom_search_field.dart';
import 'package:hoooob_app/common_widgets/from_to_icon_widget.dart';
import 'package:hoooob_app/common_widgets/loader_widget.dart';
import 'package:hoooob_app/features/home/controllers/search_tripe_controller.dart';
import 'package:hoooob_app/features/home/widgets/add_passengers_widget.dart';
import 'package:hoooob_app/features/home/widgets/from_station_widget.dart';
import 'package:hoooob_app/features/home/widgets/to_station_widget.dart';
import 'package:hoooob_app/features/home/widgets/to_text_widget.dart';
import 'package:hoooob_app/features/home/widgets/trip_date_picker.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/location/view/pick_map_screen.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/features/splash/controllers/config_controller.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/route_helper.dart';
import 'package:hoooob_app/util/animation_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';

import 'package:hoooob_app/util/styles.dart';
import 'package:intl/intl.dart';

class HomeLocationWidget extends StatefulWidget {
  const HomeLocationWidget({super.key});

  @override
  State<HomeLocationWidget> createState() => _HomeLocationWidgetState();
}

FocusNode pickLocationFocus = FocusNode();
FocusNode destinationLocationFocus = FocusNode();

class _HomeLocationWidgetState extends State<HomeLocationWidget> {
  @override
  Widget build(BuildContext context) {
    print('HomeLocationWidget: Building widget'); // Debug print
    var size = MediaQuery.of(context).size;
    return GetBuilder<LocationController>(builder: (locationController) {
      return GetBuilder<RideController>(builder: (rideController) {
        return Stack(clipBehavior: Clip.none, children: [
          SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeExtraOverLarge,
                Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeSmall,
              ),
              child: Container(
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
                                          : size.height * 0.09,
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
                                    FromStationWidget(
                                      size: size,
                                      rideController: rideController,
                                      locationController: locationController,
                                    ),
                                    ToTextWidget(),
                                    ToStationWidget(
                                      size: size,
                                      rideController: rideController,
                                      locationController: locationController,
                                    ),
                                    SizedBox(height: Dimensions.fontSizeLarge),
                                    // Add Breakpoints Section
                                    // InkWell(
                                    //   onTap: () {
                                    //     if (rideController.rideDetails !=
                                    //         null) {
                                    //       showCustomSnackBar(
                                    //           'your_ride_is_ongoing_complete'
                                    //               .tr,
                                    //           isError: true);
                                    //     } else {
                                    //       locationController.addBreakpoint();
                                    //     }
                                    //   },
                                    //   child: Container(
                                    //     height: size.height * 0.05,
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal:
                                    //             Dimensions.paddingSizeSmall),
                                    //     decoration: BoxDecoration(
                                    //       border: Border.all(
                                    //         color:
                                    //             Theme.of(context).primaryColor,
                                    //         width: 1.5,
                                    //       ),
                                    //       color: Theme.of(context)
                                    //           .primaryColor
                                    //           .withOpacity(0.1),
                                    //       borderRadius: BorderRadius.circular(
                                    //           Dimensions.radiusDefault),
                                    //     ),
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: [
                                    //         Icon(
                                    //           Icons.add_location_alt,
                                    //           color: Theme.of(context)
                                    //               .primaryColor,
                                    //           size: 20,
                                    //         ),
                                    //         const SizedBox(width: 8),
                                    //         Text(
                                    //           'إضافة نقطة توقف',
                                    //           style: textRegular.copyWith(
                                    //             fontSize:
                                    //                 Dimensions.fontSizeLarge,
                                    //             color: Theme.of(context)
                                    //                 .primaryColor,
                                    //             fontWeight: FontWeight.w600,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),

                                    // Display Breakpoints
                                    // if (locationController
                                    //     .breakpoints.isNotEmpty)
                                    //   Column(
                                    //     children: [
                                    //       SizedBox(
                                    //           height: Dimensions.fontSizeLarge),
                                    //       ...locationController.breakpoints
                                    //           .asMap()
                                    //           .entries
                                    //           .map((entry) {
                                    //         int index = entry.key;
                                    //         var breakpoint = entry.value;
                                    //         return Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               bottom: 8.0),
                                    //           child: Row(
                                    //             children: [
                                    //               Expanded(
                                    //                 child: InkWell(
                                    //                   onTap: () {
                                    //                     if (rideController
                                    //                             .rideDetails !=
                                    //                         null) {
                                    //                       showCustomSnackBar(
                                    //                           'your_ride_is_ongoing_complete'
                                    //                               .tr,
                                    //                           isError: true);
                                    //                     } else {
                                    //                       RouteHelper
                                    //                           .goPageAndHideTextField(
                                    //                         context,
                                    //                         PickMapScreen(
                                    //                           type: LocationType
                                    //                               .to,
                                    //                           // You might want to create a new type for breakpoints
                                    //                           oldLocationExist:
                                    //                               false,
                                    //                           onLocationPicked:
                                    //                               (position,
                                    //                                   address) {
                                    //                             locationController
                                    //                                 .updateBreakpoint(
                                    //                                     index,
                                    //                                     address,
                                    //                                     position);
                                    //                           },
                                    //                         ),
                                    //                       );
                                    //                     }
                                    //                   },
                                    //                   child: Container(
                                    //                     height:
                                    //                         size.height * 0.05,
                                    //                     padding: const EdgeInsets
                                    //                         .symmetric(
                                    //                         horizontal: Dimensions
                                    //                             .paddingSizeSmall),
                                    //                     decoration:
                                    //                         BoxDecoration(
                                    //                       border: Border.all(
                                    //                         color:
                                    //                             Colors.orange,
                                    //                         width: 1.0,
                                    //                       ),
                                    //                       color: Get.isDarkMode
                                    //                           ? Theme.of(
                                    //                                   context)
                                    //                               .cardColor
                                    //                           : Theme.of(
                                    //                                   context)
                                    //                               .cardColor,
                                    //                       borderRadius: BorderRadius
                                    //                           .circular(Dimensions
                                    //                               .radiusDefault),
                                    //                     ),
                                    //                     child: Row(children: [
                                    //                       const SizedBox(
                                    //                           width: Dimensions
                                    //                               .paddingSizeExtraSmall),
                                    //                       Icon(
                                    //                         Icons
                                    //                             .radio_button_checked,
                                    //                         color:
                                    //                             Colors.orange,
                                    //                         size: 16,
                                    //                       ),
                                    //                       const SizedBox(
                                    //                           width: 8),
                                    //                       Expanded(
                                    //                         child: Text(
                                    //                           breakpoint[
                                    //                                   'address'] ??
                                    //                               'نقطة توقف ${index + 1}',
                                    //                           style: textRegular
                                    //                               .copyWith(
                                    //                                   fontSize:
                                    //                                       Dimensions
                                    //                                           .fontSizeLarge),
                                    //                           maxLines: 1,
                                    //                           overflow:
                                    //                               TextOverflow
                                    //                                   .ellipsis,
                                    //                         ),
                                    //                       ),
                                    //                       const SizedBox(
                                    //                           width: Dimensions
                                    //                               .paddingSizeSmall),
                                    //                       Icon(
                                    //                         Icons.location_on,
                                    //                         color:
                                    //                             Colors.orange,
                                    //                         size: 20,
                                    //                       ),
                                    //                     ]),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               const SizedBox(width: 8),
                                    //               InkWell(
                                    //                 onTap: () =>
                                    //                     locationController
                                    //                         .removeBreakpoint(
                                    //                             index),
                                    //                 child: Container(
                                    //                   width: 30,
                                    //                   height: 30,
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(15),
                                    //                     color: Colors.red
                                    //                         .withOpacity(0.1),
                                    //                     border: Border.all(
                                    //                         color: Colors.red,
                                    //                         width: 1),
                                    //                   ),
                                    //                   child: Icon(
                                    //                     Icons.close,
                                    //                     color: Colors.red,
                                    //                     size: 16,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         );
                                    //       }).toList(),
                                    //     ],
                                    //   ),

                                    SizedBox(height: Dimensions.fontSizeLarge),

                                    // Add Passengers Section

                                    AddPassengersWidget(
                                      size: size,
                                      rideController: rideController,
                                      locationController: locationController,
                                    ),
                                    SizedBox(height: Dimensions.fontSizeLarge),
                                    TripDatePicker(
                                      size: size,
                                      locationController: locationController,
                                    ),
                                    SizedBox(height: Dimensions.fontSizeLarge),
                                    SizedBox(
                                      width: locationController.extraTwoRoute
                                          ? 0
                                          : Dimensions.paddingSizeSmall,
                                    ),
                                    if (locationController.extraOneRoute)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            child: Text(
                                              'to'.tr,
                                              style: textRegular.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: Dimensions
                                                          .paddingSizeSmall),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        width: 1),
                                                    color: Get.isDarkMode
                                                        ? Theme.of(context)
                                                            .cardColor
                                                        : Theme.of(context)
                                                            .cardColor
                                                            .withOpacity(.25),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radiusDefault),
                                                  ),
                                                  child: Row(children: [
                                                    const SizedBox(
                                                        width: Dimensions
                                                            .paddingSizeExtraSmall),
                                                    Expanded(
                                                        child:
                                                            CustomSearchField(
                                                                isReadOnly:
                                                                    rideController.rideDetails ==
                                                                            null
                                                                        ? false
                                                                        : true,
                                                                controller:
                                                                    locationController
                                                                        .extraRouteOneController,
                                                                hint:
                                                                    'extra_route_one'
                                                                        .tr,
                                                                onChanged:
                                                                    (value) async {
                                                                  return await Get
                                                                          .find<
                                                                              LocationController>()
                                                                      .searchLocation(
                                                                    context,
                                                                    value,
                                                                    type: LocationType
                                                                        .extraOne,
                                                                  );
                                                                },
                                                                onTap: () {
                                                                  if (rideController
                                                                          .rideDetails !=
                                                                      null) {
                                                                    showCustomSnackBar(
                                                                        'your_ride_is_ongoing_complete'
                                                                            .tr,
                                                                        isError:
                                                                            true);
                                                                  }
                                                                })),
                                                    const SizedBox(
                                                        width: Dimensions
                                                            .paddingSizeSmall),
                                                    InkWell(
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
                                                                    type: LocationType
                                                                        .extraOne,
                                                                    oldLocationExist:
                                                                        locationController.pickPosition.latitude >
                                                                                0
                                                                            ? true
                                                                            : false,
                                                                  ));
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.place,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              const SizedBox(
                                                width:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    color:
                                                        Colors.redAccent[100]),
                                                child: InkWell(
                                                  onTap: () =>
                                                      locationController
                                                          .setExtraRoute(
                                                              remove: true),
                                                  child: Icon(Icons.clear,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    locationController.extraTwoRoute
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: Dimensions
                                                      .paddingSizeExtraSmall,
                                                ),
                                                child: Text(
                                                  'to'.tr,
                                                  style: textRegular.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: Dimensions
                                                            .paddingSizeSmall,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                        color: Get.isDarkMode
                                                            ? Theme.of(context)
                                                                .cardColor
                                                            : Theme.of(context)
                                                                .cardColor,
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusDefault),
                                                      ),
                                                      child: Row(children: [
                                                        const SizedBox(
                                                            width: Dimensions
                                                                .paddingSizeExtraSmall),
                                                        Expanded(
                                                            child:
                                                                CustomSearchField(
                                                                    isReadOnly: rideController.rideDetails ==
                                                                            null
                                                                        ? false
                                                                        : true,
                                                                    controller:
                                                                        locationController
                                                                            .extraRouteTwoController,
                                                                    hint:
                                                                        'extra_route_two'
                                                                            .tr,
                                                                    onChanged:
                                                                        (value) async {
                                                                      return await Get.find<
                                                                              LocationController>()
                                                                          .searchLocation(
                                                                        context,
                                                                        value,
                                                                        type: LocationType
                                                                            .extraTwo,
                                                                      );
                                                                    },
                                                                    onTap: () {
                                                                      if (rideController
                                                                              .rideDetails !=
                                                                          null) {
                                                                        showCustomSnackBar(
                                                                            'your_ride_is_ongoing_complete'
                                                                                .tr,
                                                                            isError:
                                                                                true);
                                                                      }
                                                                    })),
                                                        const SizedBox(
                                                            width: Dimensions
                                                                .paddingSizeSmall),
                                                        InkWell(
                                                          onTap: () {
                                                            if (rideController
                                                                    .rideDetails !=
                                                                null) {
                                                              showCustomSnackBar(
                                                                  'your_ride_is_ongoing_complete'
                                                                      .tr,
                                                                  isError:
                                                                      true);
                                                            } else {
                                                              RouteHelper
                                                                  .goPageAndHideTextField(
                                                                      context,
                                                                      PickMapScreen(
                                                                        type: LocationType
                                                                            .extraTwo,
                                                                        oldLocationExist: locationController.pickPosition.latitude >
                                                                                0
                                                                            ? true
                                                                            : false,
                                                                      ));
                                                            }
                                                          },
                                                          child: Icon(
                                                              Icons.place,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeSmall,
                                                  ),
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100)),
                                                        color: Colors
                                                            .redAccent[100]),
                                                    child: InkWell(
                                                      onTap: () =>
                                                          locationController
                                                              .setExtraRoute(
                                                                  remove: true),
                                                      child: Icon(Icons.clear,
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: Dimensions.paddingSize,
                                    ),
                                    (!Get.find<ConfigController>()
                                                .config!
                                                .addIntermediatePoint! ||
                                            locationController.extraTwoRoute)
                                        ? const SizedBox()
                                        : Container(),
                                    // Row(
                                    //   children: [
                                    //     InkWell(
                                    //       onTap: () =>
                                    //           locationController
                                    //               .setExtraRoute(),
                                    //       child: Container(
                                    //         height: 30,
                                    //         width: 30,
                                    //         decoration: BoxDecoration(
                                    //           color: Get.isDarkMode
                                    //               ? Theme.of(context)
                                    //               .cardColor
                                    //               : Theme.of(context)
                                    //               .primaryColor
                                    //               .withOpacity(.50),
                                    //           borderRadius: BorderRadius
                                    //               .circular(Dimensions
                                    //               .radiusDefault),
                                    //         ),
                                    //         child: const Icon(Icons.add,
                                    //             color: Colors.amber),
                                    //       ),
                                    //     ),
                                    //     // SizedBox(
                                    //     //   width: Dimensions
                                    //     //       .paddingSizeDefault,
                                    //     // ),
                                    //     // Text(
                                    //     //   'add_route'.tr,
                                    //     //   style: textRegular.copyWith(
                                    //     //     fontSize: Dimensions
                                    //     //         .fontSizeLarge,
                                    //     //     fontWeight: FontWeight.w400,
                                    //     //     color: Theme.of(context)
                                    //     //         .primaryColor,
                                    //     //   ),
                                    //     // ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //     height:
                                    //     Dimensions.paddingSizeDefault),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeExtraLarge,
                          Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeExtraLarge,
                          Dimensions.paddingSizeExtraLarge,
                        ),
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   'you_can_add_multiple_route_to'.tr,
                                //   style: textRegular.copyWith(
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: Dimensions.fontSizeExtraLarge,
                                //     color: Colors.black,
                                //   ),
                                // ),
                                //=====================================
                                ValueListenableBuilder(
                                  valueListenable:
                                      Get.find<SearchTripeController>()
                                          .isLoadingSearchTripe,
                                  builder: (context, isLoading, child) {
                                    return isLoading
                                        ? SizedBox(
                                            height: size.height * 0.04 + 5,
                                            child: LoaderWidget())
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              width: size.width * 0.35 + 1,
                                              height: size.height * 0.036,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: InkWell(
                                                onTap: () async {
                                                  final locationController =
                                                      Get.find<
                                                          LocationController>();
                                                  final searchTripController =
                                                      Get.find<
                                                          SearchTripeController>();

                                                  ScaffoldMessenger.of(
                                                          Get.context!)
                                                      .removeCurrentSnackBar();

                                                  if (locationController
                                                              .fromAddress ==
                                                          null ||
                                                      locationController
                                                              .fromAddress!
                                                              .address ==
                                                          null ||
                                                      locationController
                                                          .fromAddress!
                                                          .address!
                                                          .isEmpty) {
                                                    showCustomSnackBar(
                                                        'pickup_location_is_required'
                                                            .tr);
                                                    return;
                                                  }

                                                  if (locationController
                                                              .toAddress ==
                                                          null ||
                                                      locationController
                                                              .toAddress!
                                                              .address ==
                                                          null ||
                                                      locationController
                                                          .toAddress!
                                                          .address!
                                                          .isEmpty) {
                                                    showCustomSnackBar(
                                                        'destination_location_is_required'
                                                            .tr);

                                                    return;
                                                  }

                                                  if (locationController
                                                          .fromAddress!
                                                          .address ==
                                                      locationController
                                                          .toAddress!.address) {
                                                    showCustomSnackBar(
                                                        'start_and_end_cannot_be_same'
                                                            .tr);

                                                    return;
                                                  }

                                                  if (locationController
                                                          .addPassengersController
                                                          .text
                                                          .isEmpty ||
                                                      int.tryParse(
                                                              locationController
                                                                  .addPassengersController
                                                                  .text) ==
                                                          null) {
                                                    showCustomSnackBar(
                                                        'passengers_number_is_required'
                                                            .tr);
                                                    return;
                                                  }

                                                  if (locationController
                                                      .dateController
                                                      .text
                                                      .isEmpty) {
                                                    showCustomSnackBar(
                                                        'date_is_required'.tr);

                                                    return;
                                                  }

                                                  rideController.loading = true;
                                                  rideController.update();

                                                  try {
                                                    final availableSeats = int
                                                        .parse(locationController
                                                            .addPassengersController
                                                            .text);
                                                    final dateTime =
                                                        DateTime.parse(
                                                            locationController
                                                                .dateController
                                                                .text);
                                                    final formattedDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(dateTime);

                                                    searchTripController
                                                        .setLocationData(
                                                      startLat:
                                                          locationController
                                                                  .fromAddress!
                                                                  .latitude ??
                                                              0.0,
                                                      startLng:
                                                          locationController
                                                                  .fromAddress!
                                                                  .longitude ??
                                                              0.0,
                                                      endLat: locationController
                                                              .toAddress!
                                                              .latitude ??
                                                          0.0,
                                                      endLng: locationController
                                                              .toAddress!
                                                              .longitude ??
                                                          0.0,
                                                      startAddress:
                                                          locationController
                                                                  .fromAddress!
                                                                  .address ??
                                                              '',
                                                      endAddress:
                                                          locationController
                                                                  .toAddress!
                                                                  .address ??
                                                              '',
                                                      availableSeats:
                                                          availableSeats,
                                                      startTime: formattedDate,
                                                    );

                                                    // final result =
                                                    //     searchTripController
                                                    //         .getAllSearchTripe(
                                                    //             '');

                                                    AnimationHelper
                                                        .buttonAnimation(
                                                      child: Icon(Icons.check,
                                                          color: Colors.white),
                                                      isVisible: true,
                                                    );
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            Get.context!)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              'error_occurred'
                                                                  .tr)),
                                                    );
                                                  } finally {
                                                    rideController.loading =
                                                        false;
                                                    rideController.update();
                                                  }
                                                },
                                                child: rideController.loading
                                                    ? SpinKitCircle(
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                        size: 40.0,
                                                      )
                                                    : AnimationHelper
                                                        .buttonAnimation(
                                                        child: Center(
                                                          child: Text(
                                                            'search'.tr,
                                                            style: textRegular
                                                                .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        isVisible: true,
                                                      ),
                                              ),
                                              // InkWell(
                                              //   onTap: () {
                                              //     //                                         Navigator.of(context).push(
                                              //     //                                             MaterialPageRoute(
                                              //     //                                                 builder: (_) =>
                                              //     // // <<<<<<< Updated upstream
                                              //     // //                                                     SearchTripsScreen()));
                                              //     // // =======
                                              //     //
                                              //     //                                                     PreviewTripScreen(
                                              //     //                                                         type: LocationType
                                              //     //                                                             .from)));
                                              //     //                                       Navigator
                                              //     //                                       .push(context, MaterialPageRoute(builder: (_)=>SearchTripsScreen()));

                                              //     WidgetsBinding.instance
                                              //         .addPostFrameCallback(
                                              //             (_) {
                                              //       int availableSeats = int
                                              //           .parse(locationController
                                              //               .addPassengersController
                                              //               .text);
                                              //       DateTime dateTime =
                                              //           DateTime.parse(
                                              //               locationController
                                              //                   .dateController
                                              //                   .text);
                                              //       String formattedDate =
                                              //           DateFormat('yyyy-MM-dd')
                                              //               .format(dateTime);

                                              //       // Set location data in SearchTripeController
                                              //       Get.find<
                                              //               SearchTripeController>()
                                              //           .setLocationData(
                                              //         startLat:
                                              //             locationController
                                              //                     .fromAddress!
                                              //                     .latitude ??
                                              //                 0.0,
                                              //         startLng:
                                              //             locationController
                                              //                     .fromAddress!
                                              //                     .longitude ??
                                              //                 0.0,
                                              //         endLat: locationController
                                              //                 .toAddress!
                                              //                 .latitude ??
                                              //             0.0,
                                              //         endLng: locationController
                                              //                 .toAddress!
                                              //                 .longitude ??
                                              //             0.0,
                                              //         startAddress:
                                              //             locationController
                                              //                     .fromAddress!
                                              //                     .address ??
                                              //                 '',
                                              //         endAddress:
                                              //             locationController
                                              //                     .toAddress!
                                              //                     .address ??
                                              //                 '',
                                              //         availableSeats:
                                              //             availableSeats,
                                              //         startTime: formattedDate,
                                              //       );

                                              //       Get.find<
                                              //               SearchTripeController>()
                                              //           .getAllSearchTripe('');
                                              //     });

                                              //     // if (Get.find<ConfigController>()
                                              //     //             .config!
                                              //     //             .maintenanceMode !=
                                              //     //         null &&
                                              //     //     Get.find<ConfigController>()
                                              //     //             .config!
                                              //     //             .maintenanceMode!
                                              //     //             .maintenanceStatus ==
                                              //     //         1 &&
                                              //     //     Get.find<ConfigController>()
                                              //     //             .config!
                                              //     //             .maintenanceMode!
                                              //     //             .selectedMaintenanceSystem!
                                              //     //             .userApp ==
                                              //     //         1) {
                                              //     //   showCustomSnackBar(
                                              //     //       'maintenance_mode_on_for_ride'.tr,
                                              //     //       isError: true);
                                              //     // } else {
                                              //     //   if (locationController
                                              //     //               .fromAddress ==
                                              //     //           null ||
                                              //     //       locationController
                                              //     //               .fromAddress!.address ==
                                              //     //           null ||
                                              //     //       locationController.fromAddress!
                                              //     //           .address!.isEmpty) {
                                              //     //     showCustomSnackBar(
                                              //     //         'pickup_location_is_required'
                                              //     //             .tr);
                                              //     //     FocusScope.of(context).requestFocus(
                                              //     //         pickLocationFocus);
                                              //     //   } else if (locationController
                                              //     //       .pickupLocationController
                                              //     //       .text
                                              //     //       .isEmpty) {
                                              //     //     showCustomSnackBar(
                                              //     //         'pickup_location_is_required'
                                              //     //             .tr);
                                              //     //     FocusScope.of(context).requestFocus(
                                              //     //         pickLocationFocus);
                                              //     //   } else if (locationController
                                              //     //               .toAddress ==
                                              //     //           null ||
                                              //     //       locationController
                                              //     //               .toAddress!.address ==
                                              //     //           null ||
                                              //     //       locationController.toAddress!
                                              //     //           .address!.isEmpty) {
                                              //     //     showCustomSnackBar(
                                              //     //         'destination_location_is_required'
                                              //     //             .tr);
                                              //     //     FocusScope.of(context).requestFocus(
                                              //     //         destinationLocationFocus);
                                              //     //   } else if (locationController
                                              //     //       .destinationLocationController
                                              //     //       .text
                                              //     //       .isEmpty) {
                                              //     //     showCustomSnackBar(
                                              //     //         'destination_location_is_required'
                                              //     //             .tr);
                                              //     //     FocusScope.of(context).requestFocus(
                                              //     //         destinationLocationFocus);
                                              //     //   } else {
                                              //     //     rideController
                                              //     //         .getEstimatedFare(false)
                                              //     //         .then((value) {
                                              //     //       if (value.statusCode == 200) {
                                              //     //         Get.find<LocationController>()
                                              //     //             .initAddLocationData();
                                              //     //         Get.to(() => const MapScreen(
                                              //     //               fromScreen:
                                              //     //                   MapScreenType.ride,
                                              //     //               isShowCurrentPosition:
                                              //     //                   false,
                                              //     //             ));
                                              //     //         Get.find<RideController>()
                                              //     //             .updateRideCurrentState(
                                              //     //                 RideState.initial);
                                              //     //       }
                                              //     //     });
                                              //     //     // Get.find<RideController>().getDirection();
                                              //     //   }
                                              //     // }
                                              //   },
                                              //   child: rideController.loading
                                              //       ? SpinKitCircle(
                                              //           color: Theme.of(context)
                                              //               .cardColor,
                                              //           size: 40.0)
                                              //       : Center(
                                              //           child: Text(
                                              //             'search'.tr,
                                              //             style: textRegular
                                              //                 .copyWith(
                                              //               fontSize: Dimensions
                                              //                   .fontSizeDefault,
                                              //               fontWeight:
                                              //                   FontWeight.w700,
                                              //               color: Colors.white,
                                              //             ),
                                              //           ),
                                              //         ),
                                              // ),
                                            ),
                                          );
                                  },
                                ),
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
          ])),
          locationController.resultShow
              ? Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () =>
                        locationController.setSearchResultShowHide(show: false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.paddingSizeDefault),
                      ),
                      margin: EdgeInsets.fromLTRB(
                          30, locationController.topPosition, 30, 0),
                      child: ListView.builder(
                        itemCount: locationController.predictionList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.find<LocationController>().setLocation(
                                fromSearch: true,
                                locationController
                                    .predictionList[index].placeId!,
                                locationController
                                    .predictionList[index].description!,
                                null,
                                type: locationController.locationType,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault,
                                horizontal: Dimensions.paddingSizeSmall,
                              ),
                              child: Row(children: [
                                const Icon(Icons.location_on),
                                Expanded(
                                    child: Text(
                                  locationController
                                      .predictionList[index].description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                )),
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ]);
      });
    });
  }
}
