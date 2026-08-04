import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/features/location/widget/location_search_dialog.dart';
import 'package:hoooob_app/features/location/widget/nearest_points_shimmer.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/theme/theme_controller.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';

class PickMapScreen extends StatefulWidget {
  final LocationType type;
  final bool oldLocationExist;
  final Function(Position position, String address)? onLocationPicked;
  const PickMapScreen(
      {super.key,
      this.onLocationPicked,
      required this.type,
      this.oldLocationExist = false});

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  GoogleMapController? _mapController;
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();

    if (widget.onLocationPicked != null) {
      Get.find<LocationController>().setPickData(widget.type);
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer? _debounce;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: GetBuilder<LocationController>(builder: (locationController) {
            return Stack(children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: widget.oldLocationExist
                      ? LatLng(locationController.pickPosition.latitude,
                          locationController.pickPosition.longitude)
                      : widget.onLocationPicked != null
                          ? LatLng(locationController.position.latitude,
                              locationController.position.longitude)
                          : locationController.initialPosition,
                  zoom: 16,
                ),
                minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;

                  Get.find<LocationController>().mapController = mapController;

                  Future.delayed(const Duration(milliseconds: 1000))
                      .then((value) {
                    if (widget.onLocationPicked == null &&
                        !widget.oldLocationExist) {
                      Get.find<LocationController>().updatePosition(
                        _cameraPosition?.target ??
                            locationController.initialPosition,
                        false,
                        widget.type,
                      );
                    }
                  });
                },
                zoomControlsEnabled: false,
                onCameraMove: (CameraPosition cameraPosition) {
                  _cameraPosition = cameraPosition;
                },
                onCameraMoveStarted: () {
                  if (Get.find<LocationController>().selectedPoint == null) {
                    locationController.disableButton();
                  }
                },
                onCameraIdle: () {
                  try {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();

                    _debounce =
                        Timer(const Duration(milliseconds: 500), () async {
                      final controller = Get.find<LocationController>();

                      LatLng target = _cameraPosition!.target;

                      controller.picking = true;
                      controller.update();

                      controller.getNearestStartPoints(target);

                      controller.picking = false;
                      controller.update();
                    });
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
                style: Get.isDarkMode
                    ? Get.find<ThemeController>().darkMap
                    : Get.find<ThemeController>().lightMap,
              ),
              Center(
                // map_location_icon.svg
                child: !locationController.loading
                    ? SvgPicture.asset(Images.mapLocationIconSvg,
                        height: 50, width: 50)
                    : SpinKitCircle(
                        color: Theme.of(context).primaryColor, size: 40.0),
              ),
              Positioned(
                  top: Dimensions.paddingSizeLarge,
                  left: Dimensions.paddingSizeSmall,
                  right: Dimensions.paddingSizeSmall,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          // Wrap the InkWell in Expanded
                          child: InkWell(
                            onTap: () => Get.dialog(LocationSearchDialog(
                                mapController: _mapController!,
                                type: widget.type)),
                            child: Container(
                              height: 34,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffCBCBCB),
                                ),
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusMedium),
                              ),
                              child: Row(children: [
                                Image.asset(
                                  Images.searchNormal,
                                  height: 19,
                                  width: 19,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "ابحث عن نقطة الانطلاق",

                                    // locationController.pickAddress,
                                    style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8), // Add some spacing
                        Image.asset(Images.arrowLeft, height: 34, width: 34),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          // Wrap the InkWell in Expanded
                          child: InkWell(
                            onTap: () => Get.find<LocationController>()
                                .getCurrentPosition(
                                    mapController: _mapController),
                            child: Container(
                              height: 34,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusMedium),
                              ),
                              child: Row(children: [
                                Image.asset(
                                  Images.gps,
                                  height: 19,
                                  width: 19,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "اختيار موقعك الحالي",
                                    // locationController.pickAddress,
                                    style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        const SizedBox(width: 43), // Add some spacing
                      ],
                    )
                  ])),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: locationController.picking
                      ? const NearestPointsShimmer()
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, -1),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'أقرب نقطة للانطلاق هي:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              ...locationController.nearestPoints.map((point) {
                                bool selected =
                                    locationController.selectedPoint?.id ==
                                        point.id;

                                return GestureDetector(
                                  onTap: () {
                                    locationController.moveCameraToPoint(point);
                                    locationController.selectStartPoint(point);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7F7FC),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: selected
                                            ? Color(0xFF002366)
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(Images.location,
                                            height: 23, width: 23),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            point.name,
                                            style: TextStyle(
                                              color: selected
                                                  ? Color(0xFF002366)
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(0xFF002366), // Dark blue color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  onPressed: (locationController
                                              .buttonDisabled ||
                                          locationController.loading)
                                      ? null
                                      : () {
                                          if (locationController
                                                      .pickPosition.latitude !=
                                                  0 &&
                                              locationController
                                                  .pickAddress.isNotEmpty) {
                                            if (widget.onLocationPicked !=
                                                null) {
                                              locationController
                                                  .setAddAddressData(
                                                      widget.type);
                                              widget.onLocationPicked!(
                                                  locationController
                                                      .pickPosition,
                                                  locationController
                                                      .pickAddress);
                                              Get.back();
                                            } else {
                                              Address address = Address(
                                                latitude: locationController
                                                    .pickPosition.latitude,
                                                longitude: locationController
                                                    .pickPosition.longitude,
                                                addressLabel: 'others',
                                                address: locationController
                                                    .pickAddress,
                                                zoneId:
                                                    locationController.zoneID,
                                              );
                                              locationController
                                                  .saveAddressAndNavigate(
                                                      address, widget.type);
                                            }
                                          } else {
                                            showCustomSnackBar(
                                                'pick_an_address'.tr);
                                          }
                                        },
                                  child: Text(
                                    'موافق',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
            ]);
          }),
        ),
      ),
    );
  }
}


              // GetBuilder<BottomMenuController>(builder: (menuController) {
              //   return Positioned(
              //       child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Padding(
              //       padding: const EdgeInsets.all(0),
              //       child: Container(
              //         height: 65,
              //         decoration: BoxDecoration(
              //           // borderRadius: BorderRadius.circular(20),
              //           color: Theme.of(context).cardColor,
              //           boxShadow: [
              //             BoxShadow(
              //                 offset: const Offset(1, -1),
              //                 blurRadius: 4,
              //                 spreadRadius: 1,
              //                 color: Colors.grey.withOpacity(.3))
              //           ],
              //         ),
              //         child: DashboardScreen(),
              //       ),
              //     ),
              //   ));
              // }),