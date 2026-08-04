import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/loader_widget.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/location/view/pick_map_screen.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';

class AccessLocationScreen extends StatelessWidget {
  const AccessLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        appBar: AppBarWidget(
          title: 'set_location'.tr,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeOverLarge,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
          child: Center(child:
              GetBuilder<LocationController>(builder: (locationController) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'find_driver_near_you'.tr,
                    textAlign: TextAlign.start,
                    style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge22,
                      fontWeight: FontWeight.w700,
                      color: Get.isDarkMode
                          ? Theme.of(context).primaryColorLight
                          : Color(0xFF000000),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'please_select_you_location_to_start_finding_available_driver_near_you'
                          .tr,
                      textAlign: TextAlign.start,
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge15,
                        color: Get.isDarkMode
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Center(
                      child: Image.asset(Images.carLocationMap, height: 240)),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  const BottomButton(),
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Column(children: [
              ButtonWidget(
                radius: 15,
                buttonText: 'use_current_location'.tr,
                fontSize: Dimensions.fontSizeSmall,
                onPressed: () async {
                  if (GetPlatform.isIOS) {
                    saveAndNavigate();
                  } else {
                    Get.find<LocationController>().checkPermission(() async {
                      saveAndNavigate();
                    });
                  }
                },
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              // ButtonWidget(
              //   buttonText: 'set_from_map'.tr,
              //   transparent: true,
              //   borderWidth: 1,
              //   showBorder: true,
              //   radius: 15,
              //   fontSize: Dimensions.fontSizeSmall,
              //   onPressed: () => Get.to(() =>
              //       const PickMapScreen(type: LocationType.accessLocation)),
              // ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
            ])));
  }

  void saveAndNavigate() async {
    Get.dialog(const LoaderWidget(), barrierDismissible: false);
    Address? address =
        await Get.find<LocationController>().getCurrentLocation();
    if (address != null) {
      await Get.find<LocationController>().saveUserAddress(address);
      Get.find<BottomMenuController>().navigateToDashboard();
    } else {
      Get.back();
      bool isLocationServiceEnable =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnable) {
        showCustomSnackBar('service_not_available'.tr);
      } else {
        showCustomSnackBar('your_location_access_first'.tr);
      }
    }
  }
}
