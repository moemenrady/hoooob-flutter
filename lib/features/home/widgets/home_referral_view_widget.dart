import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/features/refer_and_earn/controllers/refer_and_earn_controller.dart';
import 'package:hoooob_app/features/splash/controllers/config_controller.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/price_converter.dart';
import 'package:hoooob_app/util/app_constants.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:share_plus/share_plus.dart';

class HomeReferralViewWidget extends StatelessWidget {
  const HomeReferralViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(1, 6), // changes position of shadow
            ),
          ]),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall,
          horizontal: Dimensions.paddingSizeLarge),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('invite&getRewards'.tr,
                        style: textSemiBold.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Get.isDarkMode
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.9)
                                : null)),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('share_code_with_your_friends'.tr,
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Get.isDarkMode
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.8)
                                : Theme.of(context).hintColor)),
                  ]),
            ),
            Image.asset(
              Images.referralIcon1,
              height: 110,
              width: 120,
            )
          ]),
          // const SizedBox(height: Dimensions.paddingSizeSmall),
          GetBuilder<ReferAndEarnController>(builder: (referAndEarnController) {
            return referAndEarnController.isLoading
                ? SpinKitCircle(
                    color: Theme.of(context).primaryColor, size: 30.0)
                : InkWell(
                    onTap: () {
                      Get.find<ReferAndEarnController>()
                          .getReferralDetails()
                          .then((value) {
                        Get.bottomSheet(
                          const ReferralViewBottomSheetWidget(),
                          backgroundColor: Theme.of(context).cardColor,
                          isDismissible: false,
                        );
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeOverLarge)),
                      child: Center(
                          child: Text(
                        'invite_friends'.tr,
                        style: textRegular.copyWith(
                            color: Get.isDarkMode
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.9)
                                : Theme.of(context).cardColor,
                            fontSize: Dimensions.fontSizeSmall),
                      )),
                    ),
                  );
          }),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class ReferralViewBottomSheetWidget extends StatelessWidget {
  const ReferralViewBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.65,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Dimensions.paddingSizeLarge),
            topLeft: Radius.circular(Dimensions.paddingSizeLarge),
          )),
      child: Column(children: [
        InkWell(
          onTap: () => Get.back(),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Image.asset(Images.crossIcon, height: 10, width: 10),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Image.asset(Images.referralIcon1, height: 120, width: 120),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text('invite&getRewards'.tr,
            style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSignUp),
          child: RichText(
              text: TextSpan(
                  text: 'referral_bottom_sheet_note'.tr,
                  style: textRegular.copyWith(
                      color: Theme.of(context).colorScheme.secondaryFixedDim,
                      fontSize: Dimensions.fontSizeSmall),
                  children: [
                    TextSpan(
                      text:
                          '  ${PriceConverter.convertPrice(Get.find<ReferAndEarnController>().referralDetails?.data?.shareCodeEarning ?? 0)}',
                      style: textRobotoBold.copyWith(
                          color:
                              Theme.of(context).colorScheme.secondaryFixedDim,
                          fontSize: Dimensions.fontSizeSmall),
                    )
                  ]),
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: Dimensions.paddingSizeLarge),
        Container(
          width: Get.width * 0.6,
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.25))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                Get.find<ReferAndEarnController>()
                        .referralDetails
                        ?.data
                        ?.referralCode ??
                    '',
                style: textBold),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(
                        text: Get.find<ReferAndEarnController>()
                                .referralDetails
                                ?.data
                                ?.referralCode ??
                            ''))
                    .then((_) {
                  showCustomSnackBar('copied'.tr, isError: false);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radiusDefault),
                      bottomRight: Radius.circular(Dimensions.radiusDefault)),
                ),
                child: Icon(Icons.copy_rounded,
                    color: Theme.of(context).primaryColor),
              ),
            )
          ]),
        ),
        const SizedBox(height: Dimensions.paddingSizeLarge),
        ButtonWidget(
            onPressed: () async {
              await Share.share(
                  'Greetings, \n ${Get.find<ConfigController>().config?.businessName} is the best ride share & parcel delivery platform in the country.'
                  ' If you are new to this don’t forget to use \n "${Get.find<ReferAndEarnController>().referralDetails?.data?.referralCode ?? ''}" \n as the referral code while sign up into ${Get.find<ConfigController>().config?.businessName}  & you will get rewarded.'
                  '\n\n ${AppConstants.baseUrl}');
            },
            width: Get.width * 0.5,
            buttonText: 'invite_friends'.tr)
      ]),
    );
  }
}
