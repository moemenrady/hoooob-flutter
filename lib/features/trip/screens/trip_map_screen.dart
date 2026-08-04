import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/theme/theme_controller.dart';

class TripMapScreen extends StatefulWidget {
  final DriverTrip trip;

  const TripMapScreen({
    super.key,
    required this.trip,
  });

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen>
    with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _isFollowingDriver = false;
  LatLng? _driverPosition;
  LatLng? _startPosition;
  LatLng? _endPosition;

  // Animation controllers for UI elements
  late AnimationController _uiAnimationController;
  late Animation<double> _uiFadeAnimation;
  late Animation<Offset> _uiSlideAnimation;

  @override
  void initState() {
    super.initState();
    print('=== TripMapScreen initState ===');
    print('=== Trip ID: ${widget.trip.routeId} ===');
    print('=== Start Address: ${widget.trip.startAddress} ===');
    print('=== End Address: ${widget.trip.endAddress} ===');

    // Initialize UI animations
    _uiAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _uiFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _uiAnimationController,
      curve: Curves.easeOut,
    ));

    _uiSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _uiAnimationController,
      curve: Curves.elasticOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMap();
      _uiAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _uiAnimationController.dispose();
    super.dispose();
  }

  void _initializeMap() {
    // Use coordinates from the trip data
    if (widget.trip.startCoordinates != null &&
        widget.trip.startCoordinates!.length >= 2) {
      _startPosition = LatLng(
        widget.trip.startCoordinates![1], // latitude
        widget.trip.startCoordinates![0], // longitude
      );
    } else {
      _startPosition =
          const LatLng(30.051931823349, 31.341623067856); // Fallback
    }

    if (widget.trip.endCoordinates != null &&
        widget.trip.endCoordinates!.length >= 2) {
      _endPosition = LatLng(
        widget.trip.endCoordinates![1], // latitude
        widget.trip.endCoordinates![0], // longitude
      );
    } else {
      _endPosition = const LatLng(30.053732822801, 31.333267316222); // Fallback
    }

    _driverPosition = _startPosition;

    _createMarkers();
    _createPolylines();
  }

  void _createMarkers() {
    _markers.clear();

    if (_startPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('start'),
          position: _startPosition!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: 'start_location'.tr,
            snippet: widget.trip.startAddress,
          ),
        ),
      );
    }

    if (_endPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('end'),
          position: _endPosition!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: 'end_location'.tr,
            snippet: widget.trip.endAddress,
          ),
        ),
      );
    }

    // Add intermediate markers along the route if polyline exists
    if (widget.trip.encodedPolyline != null &&
        widget.trip.encodedPolyline!.isNotEmpty) {
      try {
        List<LatLng> decodedPoints =
            _decodePolyline(widget.trip.encodedPolyline!);
        // Add markers at key points along the route (every few points)
        for (int i = 0; i < decodedPoints.length; i += 5) {
          if (i < decodedPoints.length) {
            _markers.add(
              Marker(
                markerId: MarkerId('route_point_$i'),
                position: decodedPoints[i],
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                infoWindow: InfoWindow(
                  title: 'Route Point',
                  snippet: 'Intermediate stop',
                ),
              ),
            );
          }
        }
      } catch (e) {
        print('Error adding route markers: $e');
      }
    }

    if (_driverPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: _driverPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: 'driver_location'.tr,
            snippet: 'current_driver_position'.tr,
          ),
        ),
      );
    }
  }

  void _createPolylines() {
    _polylines.clear();

    // Use encoded polyline if available, otherwise create simple line
    if (widget.trip.encodedPolyline != null &&
        widget.trip.encodedPolyline!.isNotEmpty) {
      try {
        List<LatLng> decodedPoints =
            _decodePolyline(widget.trip.encodedPolyline!);
        if (decodedPoints.isNotEmpty) {
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: decodedPoints,
              color:
                  const Color(0xFF1E3A8A), // Dark blue color like in the image
              width: 8, // Thicker line like in the image
              patterns: [], // Solid line, no dashes
            ),
          );
        }
      } catch (e) {
        print('Error decoding polyline: $e');
        // Fallback to simple line
        _createSimplePolyline();
      }
    } else {
      // Fallback to simple line between start and end
      _createSimplePolyline();
    }
  }

  void _createSimplePolyline() {
    if (_startPosition != null && _endPosition != null) {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [_startPosition!, _endPosition!],
          color: const Color(0xFF1E3A8A), // Dark blue color like in the image
          width: 8, // Thicker line like in the image
          patterns: [], // Solid line, no dashes
        ),
      );
    }
  }

  void _fitMarkersOnMap() {
    if (_mapController != null && _markers.isNotEmpty) {
      LatLngBounds bounds =
          _boundsFromLatLngList(_markers.map((m) => m.position).toList());
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double x0 = list.first.latitude;
    double x1 = list.first.latitude;
    double y0 = list.first.longitude;
    double y1 = list.first.longitude;

    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(
      northeast: LatLng(x1, y1),
      southwest: LatLng(x0, y0),
    );
  }

  void _openInGoogleMaps() async {
    if (_startPosition != null && _endPosition != null) {
      final url =
          'https://www.google.com/maps/dir/${_startPosition!.latitude},${_startPosition!.longitude}/${_endPosition!.latitude},${_endPosition!.longitude}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    }
  }

  void _returnToDriver() {
    if (_mapController != null && _driverPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _driverPosition!,
            zoom: 16.0,
          ),
        ),
      );
    }
  }

  void _toggleFollowDriver() {
    setState(() {
      _isFollowingDriver = !_isFollowingDriver;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'trip_map'.tr,
        showBackButton: true,
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            onMapCreated: (GoogleMapController mapController) {
              _mapController = mapController;
            },
            initialCameraPosition: CameraPosition(
              target: _startPosition ?? const LatLng(30.0444, 31.2357),
              zoom: 15.0,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            style: Get.isDarkMode
                ? Get.find<ThemeController>().darkMap
                : Get.find<ThemeController>().lightMap,
          ),

          // Control Buttons
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "fitMarkers",
                  onPressed: _fitMarkersOnMap,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.fit_screen, color: Colors.white),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "openGoogleMaps",
                  onPressed: _openInGoogleMaps,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.open_in_new, color: Colors.white),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "returnToDriver",
                  onPressed: _returnToDriver,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.location_on, color: Colors.white),
                ),
              ],
            ),
          ),

          // Follow Driver Button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              heroTag: "followDriver",
              onPressed: _toggleFollowDriver,
              backgroundColor: _isFollowingDriver
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              label: Text(
                _isFollowingDriver ? 'following'.tr : 'follow'.tr,
                style: textMedium.copyWith(color: Colors.white),
              ),
              icon: Icon(
                _isFollowingDriver ? Icons.gps_fixed : Icons.gps_not_fixed,
                color: Colors.white,
              ),
            ),
          ),

          // Trip Information Panel
          Positioned(
            top: 16,
            left: 16,
            right: 80,
            child: FadeTransition(
              opacity: _uiFadeAnimation,
              child: SlideTransition(
                position: _uiSlideAnimation,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).cardColor.withOpacity(0.95),
                          Theme.of(context).cardColor.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row
                        Row(
                          children: [
                            // Trip ID
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.confirmation_number,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '#${widget.trip.routeId}',
                                    style: textMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            // Trip Status
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.withOpacity(0.9),
                                    Colors.orange.shade600.withOpacity(0.9),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'ongoing'.tr,
                                    style: textBold.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Route Information
                        Row(
                          children: [
                            Icon(
                              Icons.my_location,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.trip.startAddress,
                                style: textMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 20,
                          width: 2,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.trip.endAddress,
                                style: textMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Trip Timeline
                        _buildTripTimeline(),
                        // Polyline Status
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: widget.trip.encodedPolyline != null &&
                                    widget.trip.encodedPolyline!.isNotEmpty
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: widget.trip.encodedPolyline != null &&
                                      widget.trip.encodedPolyline!.isNotEmpty
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.trip.encodedPolyline != null &&
                                        widget.trip.encodedPolyline!.isNotEmpty
                                    ? Icons.route
                                    : Icons.route_outlined,
                                color: widget.trip.encodedPolyline != null &&
                                        widget.trip.encodedPolyline!.isNotEmpty
                                    ? Colors.green
                                    : Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.trip.encodedPolyline != null &&
                                        widget.trip.encodedPolyline!.isNotEmpty
                                    ? 'Route loaded'
                                    : 'Route not available',
                                style: textMedium.copyWith(
                                  color: widget.trip.encodedPolyline != null &&
                                          widget
                                              .trip.encodedPolyline!.isNotEmpty
                                      ? Colors.green
                                      : Colors.orange,
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripTimeline() {
    return Column(
      children: [
        // Start Point
        _buildTimelineItem(
          title: 'start_trip'.tr,
          address: widget.trip.startAddress,
          icon: Icons.directions_car,
          iconColor: const Color(0xFF1E3A8A),
          isFirst: true,
        ),

        // Rest Stops (if any passengers)
        if (widget.trip.passengers.isNotEmpty) ...[
          for (int i = 0; i < widget.trip.passengers.length; i++)
            _buildTimelineItem(
              title: 'rest_stop'.tr,
              address: widget.trip.passengers[i].pickupAddress,
              icon: Icons.location_on,
              iconColor: Colors.green,
            ),
        ],

        // End Point
        _buildTimelineItem(
          title: 'end_trip'.tr,
          address: widget.trip.endAddress,
          icon: Icons.directions_car,
          iconColor: const Color(0xFF1E3A8A),
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String address,
    required IconData icon,
    required Color iconColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line and icon
        Column(
          children: [
            if (!isFirst)
              Container(
                width: 2,
                height: 20,
                color: const Color(0xFF1E3A8A),
              ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 12,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 20,
                color: const Color(0xFF1E3A8A),
              ),
          ],
        ),
        const SizedBox(width: 12),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).hintColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Decode Google Maps encoded polyline
  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < polyline.length) {
      int shift = 0;
      int result = 0;
      int b;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}
