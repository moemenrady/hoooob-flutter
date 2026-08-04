import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/custom_search_field.dart';
import 'package:hoooob_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:hoooob_app/features/map/screens/map_screen.dart';
import 'package:hoooob_app/features/parcel/controllers/parcel_controller.dart';
import 'package:hoooob_app/features/set_destination/widget/input_field_for_set_route.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/route_helper.dart';
import 'package:hoooob_app/localization/localization_controller.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/location/view/pick_map_screen.dart';
import 'package:hoooob_app/features/map/controllers/map_controller.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/features/splash/controllers/config_controller.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/divider_widget.dart';
import 'dart:math' as math;

class SetDestinationScreen extends StatefulWidget {
  final Address? address;
  final String? searchText;
  const SetDestinationScreen({super.key, this.address, this.searchText});

  @override
  State<SetDestinationScreen> createState() => _SetDestinationScreenState();
}

class _SetDestinationScreenState extends State<SetDestinationScreen> {
  FocusNode pickLocationFocus = FocusNode();
  FocusNode destinationLocationFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    Get.find<LocationController>().initAddLocationData();
    Get.find<LocationController>().initTextControllers();
    Get.find<RideController>().clearExtraRoute();
    Get.find<MapController>().initializeData();
    Get.find<RideController>().initData();
    Get.find<ParcelController>().updatePaymentPerson(false, notify: false);
    Get.find<LocationController>()
        .setPickUp(Get.find<LocationController>().getUserAddress());
    if (widget.address != null) {
      Get.find<LocationController>().setDestination(widget.address);
    }
    if (widget.searchText != null) {
      Get.find<LocationController>()
          .setDestination(Address(address: widget.searchText));
      Future.delayed(const Duration(seconds: 1)).then((_) {
        Get.find<LocationController>().searchLocation(
            context, widget.searchText ?? '',
            type: LocationType.to);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: BodyWidget(
      appBar: AppBarWidget(
        title: 'select_location'.tr,
        fontSize: Dimensions.fontSizeOverLarge,
        fontWeight: FontWeight.w900,
        onBackPressed: () {
          if (Navigator.canPop(context)) {
            Get.back();
          } else {
            Get.offAll(() => const DashboardScreen());
          }
        },
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
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
                        color: Theme.of(context).hintColor.withOpacity(.5),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
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
                                  Dimensions.paddingSizeSmall,
                                  0,
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    width: Dimensions.iconSizeLarge,
                                    child: Image.asset(
                                      Images.currentLocation,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                      height: locationController.extraTwoRoute
                                          ? size.height * .25
                                          : locationController.extraOneRoute
                                              ? size.height * .18
                                              : size.height * .1,
                                      width: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: VerticalDivider(
                                            thickness: 4,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                  SizedBox(
                                    width: Dimensions.iconSizeLarge,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform:
                                          Get.find<LocalizationController>()
                                                  .isLtr
                                              ? Matrix4.rotationY(0)
                                              : Matrix4.rotationY(math.pi),
                                      child: Image.asset(
                                        Images.activityDirection,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
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
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Expanded(
                                              child: CustomSearchField(
                                                  isReadOnly: rideController
                                                              .rideDetails ==
                                                          null
                                                      ? false
                                                      : true,
                                                  focusNode: pickLocationFocus,
                                                  controller: locationController
                                                      .pickupLocationController,
                                                  hint: 'pick_location'.tr,
                                                  onChanged: (value) async {
                                                    return await Get.find<
                                                            LocationController>()
                                                        .searchLocation(
                                                      context,
                                                      value,
                                                      type: LocationType.from,
                                                    );
                                                  },
                                                  onTap: () {
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
                                              width:
                                                  Dimensions.paddingSizeSmall),
                                          InkWell(
                                            onTap: () {
                                              if (rideController.rideDetails !=
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
                                                          type:
                                                              LocationType.from,
                                                          oldLocationExist:
                                                              locationController
                                                                          .pickPosition
                                                                          .latitude >
                                                                      0
                                                                  ? true
                                                                  : false,
                                                        ));
                                              }
                                            },
                                            child: Icon(Icons.place,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeExtraSmall,
                                        ),
                                        child: Text(
                                          'to'.tr,
                                          style: textRegular.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
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
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Expanded(
                                              child: CustomSearchField(
                                                  isReadOnly: rideController
                                                              .rideDetails ==
                                                          null
                                                      ? false
                                                      : true,
                                                  focusNode:
                                                      destinationLocationFocus,
                                                  controller: locationController
                                                      .destinationLocationController,
                                                  hint: 'destination'.tr,
                                                  onChanged: (value) async {
                                                    return await Get.find<
                                                            LocationController>()
                                                        .searchLocation(context,
                                                            value.trim(),
                                                            type: LocationType
                                                                .to);
                                                  },
                                                  onTap: () {
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
                                              width:
                                                  Dimensions.paddingSizeSmall),
                                          locationController.selecting
                                              ? SpinKitCircle(
                                                  color: Theme.of(context)
                                                      .cardColor,
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
                                                  child: Icon(Icons.place,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                        ]),
                                      ),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                          width: 1),
                                                      color: Get.isDarkMode
                                                          ? Theme.of(context)
                                                              .cardColor
                                                          : Theme.of(context)
                                                              .cardColor
                                                              .withOpacity(.25),
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
                                                                    return await Get.find<
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
                                                                      oldLocationExist: locationController.pickPosition.latitude >
                                                                              0
                                                                          ? true
                                                                          : false,
                                                                    ));
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.place,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
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
                                        ),
                                      locationController.extraTwoRoute
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: Dimensions
                                                              .paddingSizeSmall,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor),
                                                          color: Get.isDarkMode
                                                              ? Theme.of(
                                                                      context)
                                                                  .cardColor
                                                              : Theme.of(
                                                                      context)
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
                                                                      hint: 'extra_route_two'
                                                                          .tr,
                                                                      onChanged:
                                                                          (value) async {
                                                                        return await Get.find<LocationController>()
                                                                            .searchLocation(
                                                                          context,
                                                                          value,
                                                                          type:
                                                                              LocationType.extraTwo,
                                                                        );
                                                                      },
                                                                      onTap:
                                                                          () {
                                                                        if (rideController.rideDetails !=
                                                                            null) {
                                                                          showCustomSnackBar(
                                                                              'your_ride_is_ongoing_complete'.tr,
                                                                              isError: true);
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
                                                                          type:
                                                                              LocationType.extraTwo,
                                                                          oldLocationExist: locationController.pickPosition.latitude > 0
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
                                                                  Radius
                                                                      .circular(
                                                                          100)),
                                                          color: Colors
                                                              .redAccent[100]),
                                                      child: InkWell(
                                                        onTap: () =>
                                                            locationController
                                                                .setExtraRoute(
                                                                    remove:
                                                                        true),
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
                                          : Row(
                                              children: [
                                                InkWell(
                                                  onTap: () =>
                                                      locationController
                                                          .setExtraRoute(),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: Get.isDarkMode
                                                          ? Theme.of(context)
                                                              .cardColor
                                                          : Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(.50),
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .radiusDefault),
                                                    ),
                                                    child: const Icon(Icons.add,
                                                        color: Colors.amber),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                      .paddingSizeDefault,
                                                ),
                                                Text(
                                                  'add_route'.tr,
                                                  style: textRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeDefault),
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
                                  Text(
                                    'you_can_add_multiple_route_to'.tr,
                                    style: textRegular.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      width: size.width * .5,
                                      height: size.height * .07,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: InkWell(
                                        onTap: () {
                                          if (Get.find<ConfigController>()
                                                      .config!
                                                      .maintenanceMode !=
                                                  null &&
                                              Get.find<ConfigController>()
                                                      .config!
                                                      .maintenanceMode!
                                                      .maintenanceStatus ==
                                                  1 &&
                                              Get.find<ConfigController>()
                                                      .config!
                                                      .maintenanceMode!
                                                      .selectedMaintenanceSystem!
                                                      .userApp ==
                                                  1) {
                                            showCustomSnackBar(
                                                'maintenance_mode_on_for_ride'
                                                    .tr,
                                                isError: true);
                                          } else {
                                            if (locationController
                                                        .fromAddress ==
                                                    null ||
                                                locationController
                                                        .fromAddress!.address ==
                                                    null ||
                                                locationController.fromAddress!
                                                    .address!.isEmpty) {
                                              showCustomSnackBar(
                                                  'pickup_location_is_required'
                                                      .tr);
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      pickLocationFocus);
                                            } else if (locationController
                                                .pickupLocationController
                                                .text
                                                .isEmpty) {
                                              showCustomSnackBar(
                                                  'pickup_location_is_required'
                                                      .tr);
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      pickLocationFocus);
                                            } else if (locationController
                                                        .toAddress ==
                                                    null ||
                                                locationController
                                                        .toAddress!.address ==
                                                    null ||
                                                locationController.toAddress!
                                                    .address!.isEmpty) {
                                              showCustomSnackBar(
                                                  'destination_location_is_required'
                                                      .tr);
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      destinationLocationFocus);
                                            } else if (locationController
                                                .destinationLocationController
                                                .text
                                                .isEmpty) {
                                              showCustomSnackBar(
                                                  'destination_location_is_required'
                                                      .tr);
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      destinationLocationFocus);
                                            } else {
                                              rideController
                                                  .getEstimatedFare(false)
                                                  .then((value) {
                                                if (value.statusCode == 200) {
                                                  Get.find<LocationController>()
                                                      .initAddLocationData();
                                                  Get.to(() => const MapScreen(
                                                        fromScreen:
                                                            MapScreenType.ride,
                                                        isShowCurrentPosition:
                                                            false,
                                                      ));
                                                  Get.find<RideController>()
                                                      .updateRideCurrentState(
                                                          RideState.initial);
                                                }
                                              });
                                              // Get.find<RideController>().getDirection();
                                            }
                                          }
                                        },
                                        child: rideController.loading
                                            ? SpinKitCircle(
                                                color:
                                                    Theme.of(context).cardColor,
                                                size: 40.0)
                                            : Padding(
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .paddingSizeDefault),
                                                child: Center(
                                                  child: Text(
                                                    'done'.tr,
                                                    style: textRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraLarge,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
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
                      onTap: () => locationController.setSearchResultShowHide(
                          show: false),
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
      }),
    ));
  }
}
