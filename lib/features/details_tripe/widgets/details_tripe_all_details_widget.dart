import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsTripeAllDetailsWidget extends StatefulWidget {
  final DetailsTripeNavigateDataModel tripeData;

  const DetailsTripeAllDetailsWidget({super.key, required this.tripeData});

  @override
  State<DetailsTripeAllDetailsWidget> createState() =>
      _DetailsTripeAllDetailsWidgetState();
}

List<String> imagePath = [
  Images.userIcon,
  Images.windIcon,
  Images.windIcon,
  Images.userIcon,
  Images.userIcon,
  // Images.userIcon,
  Images.audioIcon,
  Images.audioIcon,
];
late List<String> details;

class _DetailsTripeAllDetailsWidgetState
    extends State<DetailsTripeAllDetailsWidget> {
  @override
  void initState() {
    super.initState();
    details = [
      ' ${widget.tripeData.seatsAvailable} ${'seats'.tr} ',
      (widget.tripeData.isSmoking!
          ? 'Smoking_not_allowed'.tr
          : ' Smoking_allowed'.tr),
      (widget.tripeData.isAc!
          ? 'air_conditioner_not_allowed'.tr
          : 'air_conditioner_allowed'.tr),
      'ذكور فقط',
      '  ${widget.tripeData.mainAge} ${'age'.tr} ${widget.tripeData.maxAge} ${'age'.tr} ',
      (widget.tripeData.isMusic! ? 'music_allowed'.tr : 'music_not_allowed'.tr),
      (widget.tripeData.isBages! ? 'bags_allowed'.tr : 'bags_not_allowed'.tr),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.49,
        width: size.width * 0.90,
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.01 + 5),
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
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        ),
        child: Column(
          children: [
            _userImageAndName(),
            _detailsImageAndText(),
            SizedBox(height: size.height * 0.01 + 10),
            _defaultContainerText(),
          ],
        ));
  }

  Widget _detailsImageAndText() {
    var size = MediaQuery.of(context).size;

    return Column(
      spacing: size.height * 0.01 - 1,
      children: List.generate(imagePath.length, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textDirection: index == 0 ? TextDirection.rtl : TextDirection.ltr,
              details[index],
              style: textSemiBold.copyWith(
                  // color: Theme.of(context).,
                  fontSize: Dimensions.fontSizeSmall),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Image.asset(
              imagePath[index],
              width: size.width * 0.06,
            ),
          ],
        );
      }),
    );
  }

  Widget _defaultContainerText() {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _openPickupLocationInMaps,
      child: Container(
        height: size.height * 0.08 + 6,
        width: size.width * 0.80,
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Get.isDarkMode
                  ? Theme.of(context).primaryColorDark.withOpacity(0.8)
                  : Theme.of(context).primaryColor.withOpacity(0.8),
              Get.isDarkMode
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          boxShadow: [
            BoxShadow(
              color: (Get.isDarkMode
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).primaryColor)
                  .withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Navigation icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                Images.activityDirection,
                width: 20,
                height: 20,
                color: Theme.of(context).cardColor,
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            // Text content

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'pickup_match_point'.tr,
                    style: textRegular.copyWith(
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.tripeData.pickupMatchAddress ?? 'tap_to_navigate'.tr,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textMedium.copyWith(
                      color: Theme.of(context).cardColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).cardColor.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _openPickupLocationInMaps() async {
    try {
      // Get current location from location controller
      final locationController = Get.find<LocationController>();
      final currentLat = locationController.initialPosition.latitude;
      final currentLng = locationController.initialPosition.longitude;

      // Get pickup match point coordinates
      final pickupLat = widget.tripeData.pickupMatchLat;
      final pickupLng = widget.tripeData.pickupMatchLng;

      // Debug logging
      print('🔍 Navigation Debug:');
      print('Current Location: $currentLat, $currentLng');
      print('Pickup Match Point: $pickupLat, $pickupLng');
      print('Pickup Address: ${widget.tripeData.pickupMatchAddress}');

      if (pickupLat != null && pickupLng != null) {
        // Create Google Maps navigation URL
        final url =
            'https://www.google.com/maps/dir/$currentLat,$currentLng/$pickupLat,$pickupLng';
        print('🗺️ Navigation URL: $url');

        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          print('✅ Successfully opened Google Maps');
        } else {
          // Fallback: open Google Maps with just the destination
          final fallbackUrl =
              'https://www.google.com/maps/search/?api=1&query=$pickupLat,$pickupLng';
          print('🔄 Trying fallback URL: $fallbackUrl');
          if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
            await launchUrl(Uri.parse(fallbackUrl),
                mode: LaunchMode.externalApplication);
            print('✅ Successfully opened Google Maps (fallback)');
          } else {
            print('❌ Failed to open Google Maps');
            Get.snackbar(
              'error'.tr,
              'failed_to_open_maps'.tr,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
            );
          }
        }
      } else {
        print('❌ Pickup coordinates are null');
        // Show error message if coordinates are not available
        Get.snackbar(
          'error'.tr,
          'pickup_location_not_available'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Navigation error: $e');
      // Show error message if something goes wrong
      Get.snackbar(
        'error'.tr,
        'failed_to_open_maps'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Widget _userImageAndName({
    TextDirection? textDirection,
  }) {
    var size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          Images.arrowLeft2Icon,
          width: size.width * 0.02,
          color: Theme.of(context).primaryColor,
        ),
        Spacer(),
        Text(
            textDirection: textDirection,
            widget.tripeData.driverName.toString(),
            style: textRegular.copyWith(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              fontSize: Dimensions.fontSizeLarge,
              fontWeight: FontWeight.w400,
            )),
        SizedBox(
          width: size.width * 0.02,
        ),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.01 + 2),
          child: Container(
            width: size.width * 0.07,
            height: size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(Images.userIcon))),
          ),
        ),
      ],
    );
  }
}
