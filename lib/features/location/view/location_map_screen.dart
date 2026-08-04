import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';

class LocationScreen extends StatefulWidget {
  final AddressModel? address;
  const LocationScreen({super.key, @required this.address});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late LatLng _latLng;
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: GetBuilder<LocationController>(builder: (locationController) {
          return Column(
            children: [
              // Custom Search Bar
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Back Arrow
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8BC34A),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            Images.arrowLeft,
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Search TextField
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'ابحث عن نقطة الانطلاق',
                            hintStyle: textRegular.copyWith(
                              color: Colors.grey[600],
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeDefault,
                            ),
                          ),
                          style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                          onChanged: (value) {
                            // Handle search functionality here
                            // You can implement location search logic
                          },
                        ),
                      ),

                      // Search Icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          Images.searchNormal,
                          width: 24,
                          height: 24,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Map Container
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        GoogleMap(
                          minMaxZoomPreference:
                              const MinMaxZoomPreference(0, 15),
                          initialCameraPosition: CameraPosition(
                            target: locationController.initialPosition,
                            zoom: 15,
                          ),
                          zoomGesturesEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          indoorViewEnabled: true,
                          markers: _markers,
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          onTap: (LatLng latLng) {
                            if (_mapController != null) {
                              _mapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: latLng, zoom: 17)));
                            }
                          },
                        ),

                        // Location Info Card
                        Positioned(
                          left: Dimensions.paddingSizeDefault,
                          right: Dimensions.paddingSizeDefault,
                          bottom: 20,
                          child: Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8BC34A),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'أقرب نقطة للانطلاق هي:',
                                            style: textRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            widget.address?.message ??
                                                'شارع علي بن ابي طالب هجر الحديدة القاهرة',
                                            style: textMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // OK Button
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle OK button press
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'موافق',
                      style: textMedium.copyWith(
                        color: Colors.white,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _setMarker() async {
    Uint8List destinationImageData =
        await convertAssetToUnit8List(Images.mapLocationIcon, width: 120);

    _markers = {};
    _markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: Get.find<LocationController>().initialPosition,
      icon: BitmapDescriptor.bytes(destinationImageData),
    ));

    setState(() {});
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath,
      {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
