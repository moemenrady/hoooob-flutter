import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/common_widgets/expandable_bottom_sheet.dar.dart';
import 'package:hoooob_app/common_widgets/swipable_button_widget/slider_button_widget.dart';
import 'package:hoooob_app/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:hoooob_app/features/map/controllers/map_controller.dart';
import 'package:hoooob_app/features/parcel/controllers/parcel_controller.dart';
import 'package:hoooob_app/features/parcel/widgets/tolltip_widget.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/localization/localization_controller.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

enum FindingRide { ride, parcel }

class FindingRiderWidget extends StatefulWidget {
  final FindingRide fromPage;
  final GlobalKey<ExpandableBottomSheetState> expandableKey;
  const FindingRiderWidget({
    super.key,
    required this.fromPage,
    required this.expandableKey,
  });

  @override
  State<FindingRiderWidget> createState() => _FindingRiderWidgetState();
}

class _FindingRiderWidgetState extends State<FindingRiderWidget> {
  bool isSearching = true;

  @override
  void initState() {
    Get.find<RideController>().countingTimeStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (rideController) {
        return GetBuilder<ParcelController>(
          builder: (parcelController) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
              ),
              child: isSearching
                  ? rideController.tripDetails?.type == "carpool"
                      ? _CarpoolPendingWidget(
                          tripDetails: rideController.tripDetails!,
                          expandableKey: widget.expandableKey,
                        )
                      : Column(
                          children: [
                            TollTipWidget(
                              title: rideController.selectedCategory ==
                                      RideType.parcel
                                  ? 'deliveryman'
                                  : 'rider_finding',
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Colors.grey.withOpacity(.50),
                                    color: Theme.of(context).primaryColor,
                                    value: rideController.firstCount,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Colors.grey.withOpacity(.50),
                                    color: Theme.of(context).primaryColor,
                                    value: rideController.secondCount,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Colors.grey.withOpacity(.50),
                                    color: Theme.of(context).primaryColor,
                                    value: rideController.thirdCount,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault,
                              ),
                              child: Image.asset(
                                Images.newBidFareIcon,
                                width: 70,
                                color: Theme.of(
                                  context,
                                )
                                    .buttonTheme
                                    .colorScheme!
                                    .scrim
                                    .withOpacity(0.2),
                                colorBlendMode: BlendMode.modulate,
                              ),
                            ),
                            Text(
                              widget.fromPage == FindingRide.parcel
                                  ? 'finding_deliveryman'.tr
                                  : rideController.stateCount == 0
                                      ? 'searching_for_rider'.tr
                                      : rideController.stateCount == 1
                                          ? 'please_wait_just_for_a_moment'.tr
                                          : rideController.stateCount == 2
                                              ? 'looks_like_riders_around_you_are_busy_now'
                                                  .tr
                                              : 'looks_like_riders_around_you_are_not_interested'
                                                  .tr,
                              style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            (rideController.stateCount == 2 ||
                                    widget.fromPage == FindingRide.parcel)
                                ? Text(
                                    'please_hold_on_a_little_more'.tr,
                                    style: textMedium.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  )
                                : const SizedBox(),
                            if (rideController.stateCount != 3 &&
                                widget.fromPage == FindingRide.ride)
                              const SizedBox(
                                height: Dimensions.paddingSizeLarge * 2,
                              ),
                            if (rideController.stateCount == 3 &&
                                widget.fromPage == FindingRide.ride) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeDefault,
                                  horizontal:
                                      Dimensions.paddingSizeExtraOverLarge,
                                ),
                                child: ButtonWidget(
                                  buttonText: 'keep_searching'.tr,
                                  onPressed: () {
                                    widget.expandableKey.currentState
                                        ?.contract();
                                    rideController.initCountingTimeStates(
                                      isRestart: true,
                                    );
                                  },
                                  backgroundColor:
                                      Colors.grey.withOpacity(0.25),
                                  radius: 10,
                                  textColor: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     left: Dimensions.paddingSizeExtraOverLarge ,
                              //     right: Dimensions.paddingSizeExtraOverLarge ,
                              //     bottom: Dimensions.paddingSizeDefault,
                              //   ),
                              //   child: ButtonWidget(
                              //     buttonText: 'rise_fare'.tr,
                              //     onPressed: (){
                              //      // widget.expandableKey.currentState?.contract();
                              //       rideController.updateRideCurrentState(RideState.riseFare);
                              //     },
                              //     radius: 10,
                              //   ),
                              // ),
                            ],
                            if (widget.fromPage == FindingRide.parcel)
                              const SizedBox(
                                height: Dimensions.paddingSizeDefault,
                              ),
                            !(rideController.stateCount == 3 &&
                                    widget.fromPage == FindingRide.ride)
                                ? Center(
                                    child: SliderButton(
                                      action: () {
                                        isSearching = false;
                                        widget.expandableKey.currentState
                                            ?.expand();
                                        setState(() {});
                                      },
                                      label: Text(
                                        'cancel_searching'.tr,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      dismissThresholds: 0.5,
                                      dismissible: false,
                                      shimmer: false,
                                      width: 1170,
                                      height: 40,
                                      buttonSize: 40,
                                      radius: 20,
                                      icon: Center(
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Get.find<LocalizationController>()
                                                      .isLtr
                                                  ? Icons
                                                      .arrow_forward_ios_rounded
                                                  : Icons.keyboard_arrow_left,
                                              color: Colors.grey,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      isLtr: Get.find<LocalizationController>()
                                          .isLtr,
                                      boxShadow: const BoxShadow(blurRadius: 0),
                                      buttonColor: Colors.transparent,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor.withOpacity(0.15),
                                      baseColor: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeDefault,
                          ),
                          child: Image.asset(
                            Images.cancelRideIcon,
                            width: 70,
                            color: Theme.of(
                              context,
                            ).buttonTheme.colorScheme!.scrim,
                          ),
                        ),
                        Text(
                          'are_you_sure'.tr,
                          style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                        Text(
                          'you_want_to_cancel_searching'.tr,
                          style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        rideController.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(
                                  Dimensions.paddingSizeDefault,
                                ),
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.paddingSizeDefault,
                                      horizontal:
                                          Dimensions.paddingSizeExtraOverLarge,
                                    ),
                                    child: ButtonWidget(
                                      buttonText: 'keep_searching'.tr,
                                      onPressed: () {
                                        widget.expandableKey.currentState
                                            ?.contract();
                                        isSearching = true;
                                        setState(() {});
                                        rideController.initCountingTimeStates(
                                          isRestart: true,
                                        );
                                      },
                                      backgroundColor: Colors.grey.withOpacity(
                                        0.25,
                                      ),
                                      radius: 10,
                                      textColor: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left:
                                          Dimensions.paddingSizeExtraOverLarge,
                                      right:
                                          Dimensions.paddingSizeExtraOverLarge,
                                      bottom: Dimensions.paddingSizeDefault,
                                    ),
                                    child: ButtonWidget(
                                      buttonText: 'cancel_searching'.tr,
                                      onPressed: () {
                                        //  widget.expandableKey.currentState?.contract();
                                        print(
                                          "======== ${rideController.tripDetails?.id}",
                                        );

                                        // Get the trip ID safely
                                        String? tripId =
                                            rideController.tripDetails?.id;

                                        if (tripId == null) {
                                          Get.snackbar(
                                            'Error',
                                            'No trip ID found',
                                          );
                                          return;
                                        }

                                        rideController
                                            .tripStatusUpdate(
                                          tripId,
                                          'cancelled',
                                          'ride_request_cancelled_successfully',
                                          '',
                                        )
                                            .then((value) {
                                          if (value.statusCode == 200) {
                                            rideController
                                                .updateRideCurrentState(
                                              RideState.initial,
                                            );
                                            Get.find<MapController>()
                                                .notifyMapController();
                                            Get.find<RideController>()
                                                .clearRideDetails();
                                            Get.find<BottomMenuController>()
                                                .navigateToDashboard();
                                          }
                                        });
                                      },
                                      radius: 10,
                                    ),
                                  ),
                                ],
                              ),
                        if (rideController.isLoading)
                          const SizedBox(
                            height: Dimensions.paddingSizeSignUp,
                          ),
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}

class _CarpoolPendingWidget extends StatefulWidget {
  final dynamic tripDetails;
  final GlobalKey<ExpandableBottomSheetState> expandableKey;

  const _CarpoolPendingWidget({
    required this.tripDetails,
    required this.expandableKey,
  });

  @override
  State<_CarpoolPendingWidget> createState() => _CarpoolPendingWidgetState();
}

class _CarpoolPendingWidgetState extends State<_CarpoolPendingWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _bounceController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    // Initialize animations
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotateController,
      curve: Curves.linear,
    ));

    _slideAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _openInGoogleMaps(double lat, double lng) async {
    try {
      // Get current location as origin
      Position? currentPosition;
      try {
        // Check if location services are enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          Get.snackbar(
            'Location Services Disabled',
            'Please enable location services to get directions.',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }

        // Check location permission
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            Get.snackbar(
              'Location Permission Denied',
              'Please grant location permission to get directions.',
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
            return;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          Get.snackbar(
            'Location Permission Required',
            'Location permissions are permanently denied. Please enable in settings.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // Get current position
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print('Error getting current location: $e');
        // Continue without current location if there's an error
      }

      String url;
      if (currentPosition != null) {
        // Use current location as origin and provided coordinates as destination
        url =
            'https://www.google.com/maps/dir/?api=1&origin=${currentPosition.latitude},${currentPosition.longitude}&destination=$lng,$lat&travelmode=driving';
      } else {
        // Fallback to just destination if current location is not available
        url =
            'https://www.google.com/maps/dir/?api=1&destination=$lng,$lat&travelmode=driving';
      }

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        final fallbackUrl = 'https://maps.google.com/maps?q=$lng,$lat';
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl),
              mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar(
            'Error',
            'Could not open Google Maps. Please install Google Maps app.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open Google Maps. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          // Status Header Card
          Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                  child: Icon(
                    Icons.directions_car,
                    color: Theme.of(context).primaryColor,
                    size: Dimensions.iconSizeLarge,
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'carpool_trip_pending'.tr,
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'waiting_for_driver_confirmation'.tr,
                        style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                  child: Icon(
                    Icons.hourglass_empty,
                    color: Colors.orange,
                    size: Dimensions.iconSizeMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          // Driver Info Card
          Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Driver Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: widget.tripDetails.driver != null &&
                            widget.tripDetails.driver.profileImage != null
                        ? Image.network(
                            widget.tripDetails.driver.profileImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                child: Icon(
                                  Icons.person,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            },
                          )
                        : Container(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              size: 25,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.tripDetails.driver != null
                            ? '${widget.tripDetails.driver.firstName ?? ''} ${widget.tripDetails.driver.lastName ?? ''}'
                            : 'driver'.tr,
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            _getDriverRating(),
                            style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.tripDetails.vehicle != null
                            ? '${widget.tripDetails.vehicle.model?.name ?? 'vehicle'.tr} • ${widget.tripDetails.vehicle.licencePlateNumber ?? 'N/A'}'
                            : 'vehicle_information_not_available'.tr,
                        style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          // Trip Details Card
          Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.route,
                      color: Theme.of(context).primaryColor,
                      size: Dimensions.iconSizeMedium,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      'trip_details'.tr,
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                // Pickup Location
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Text(
                        widget.tripDetails.pickupAddress ??
                            'pickup_location'.tr,
                        style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                // Destination Location
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Text(
                        widget.tripDetails.destinationAddress ??
                            'destination'.tr,
                        style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                // Trip Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoItem(
                      Icons.access_time,
                      '${_formatNumber(widget.tripDetails.estimatedTime)} min',
                      'duration'.tr,
                    ),
                    _buildInfoItem(
                      Icons.straighten,
                      '${_formatNumber(widget.tripDetails.estimatedDistance)} km',
                      'distance'.tr,
                    ),
                    _buildInfoItem(
                      Icons.attach_money,
                      '\$${widget.tripDetails.estimatedFare?.toString() ?? '0'}',
                      'fare'.tr,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          // Action Buttons
          Row(
            children: [
              // Navigate Button
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      onTap: () {
                        if (widget.tripDetails.carpoolRideLocation != null) {
                          _openInGoogleMaps(
                            widget.tripDetails.carpoolRideLocation.latitude,
                            widget.tripDetails.carpoolRideLocation.longitude,
                          );
                        }
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions,
                              color: Colors.white,
                              size: Dimensions.iconSizeMedium,
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Text(
                              'navigate'.tr,
                              style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeDefault),

              // Cancel Button
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    border: Border.all(
                      color: Theme.of(context).hintColor.withOpacity(0.3),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      onTap: () {
                        // Cancel trip logic
                        String? tripId = widget.tripDetails.id;
                        if (tripId != null) {
                          Get.find<RideController>()
                              .tripStatusUpdate(
                            tripId,
                            'cancelled',
                            'ride_request_cancelled_successfully',
                            '',
                          )
                              .then((value) {
                            if (value.statusCode == 200) {
                              Get.find<RideController>()
                                  .updateRideCurrentState(RideState.initial);
                              Get.find<MapController>().notifyMapController();
                              Get.find<RideController>().clearRideDetails();
                              Get.find<BottomMenuController>()
                                  .navigateToDashboard();
                            }
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          'cancel_trip'.tr,
                          style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNumber(dynamic value) {
    if (value == null) return '0';

    try {
      double number;
      if (value is String) {
        number = double.parse(value);
      } else if (value is double) {
        number = value;
      } else if (value is int) {
        number = value.toDouble();
      } else {
        return '0';
      }

      return number.toStringAsFixed(1);
    } catch (e) {
      return '0';
    }
  }

  String _getDriverRating() {
    try {
      // Try to get driver_avg_rating from the trip details
      if (widget.tripDetails.driverAvgRating != null) {
        return _formatNumber(widget.tripDetails.driverAvgRating);
      }

      // Fallback to a default rating
      return '4.5';
    } catch (e) {
      return '4.5';
    }
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          size: Dimensions.iconSizeMedium,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textMedium.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        Text(
          label,
          style: textRegular.copyWith(
            fontSize: Dimensions.fontSizeExtraSmall,
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
