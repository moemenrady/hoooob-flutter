import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/divider_widget.dart';
import 'package:hoooob_app/features/coupon/controllers/coupon_controller.dart';
import 'package:hoooob_app/features/coupon/domain/models/coupon_model.dart';
import 'package:hoooob_app/features/splash/controllers/config_controller.dart';
import 'package:hoooob_app/helper/date_converter.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/helper/price_converter.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class OfferCouponCardWidget extends StatelessWidget {
  final bool fromCouponScree;
  final Coupon coupon;
  final int index;
  const OfferCouponCardWidget(
      {super.key,
      required this.fromCouponScree,
      required this.coupon,
      required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<CouponController>(builder: (couponController) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(.5),
              blurRadius: 1,
              offset: const Offset(1, 2),
            )
          ],
        ),
        child: Stack(children: [
          InkWell(
            onTap: () {
              if (fromCouponScree) {
                Get.bottomSheet(CouponDetailsBottomSheet(coupon: coupon));
              }
            },
            child: Container(
              height: size.height * .15,
              width: Get.width,
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraSmall,
                horizontal: Dimensions.paddingSizeLarge,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.25)),
                color: Theme.of(context).cardColor,
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // fromCouponScree
                //     ? Stack(children: [
                //         Container(
                //           width: 65,
                //           height: 80,
                //           decoration: BoxDecoration(
                //             color: Theme.of(context).cardColor.withOpacity(0.50),
                //           ),
                //           child: Image.asset(Images.car),
                //         ),
                //         Image.asset(Images.discountCouponIcon,
                //             height: 20, width: 20)
                //       ])
                //     : const SizedBox(),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Code: ',
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!)),
                          Text('${coupon.couponCode}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: Dimensions.fontSizeLarge)),
                        ]),
                        const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.paddingSizeExtraLarge,
                              top: Dimensions.paddingSize),
                          child: Row(
                            children: [
                              Text(
                                '${coupon.amountType == 'percentage' ? '${coupon.coupon.toString().split('.')[0]} %' : PriceConverter.convertPrice(double.parse(coupon.coupon ?? '0'))} '
                                // '${coupon.categoryCoupon!.contains('all') ? 'all_rides'.tr : coupon.categoryCoupon!.toString().substring(1, coupon.categoryCoupon!.toString().length - 1)}'
                                ,
                                style: textRobotoRegular.copyWith(
                                    color: Color(0xffE01B41),
                                    fontSize: Dimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.w600),
                              ),
                              coupon.amountType == 'percentage'
                                  ? Text(
                                      'off',
                                      style: textRobotoRegular.copyWith(
                                          color: Color(0xffE01B41),
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSeven),
                        // Text(
                        //   '${'minimum_trip_amount'.tr} ${PriceConverter.convertPrice(double.parse(coupon.minTripAmount ?? '0'))}',
                        //   style: textRobotoRegular.copyWith(
                        //       fontSize: Dimensions.fontSizeSmall,
                        //       color: Theme.of(context).hintColor),
                        // ),
                        // const SizedBox(height: Dimensions.paddingSizeSeven),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Row(children: [
                        //         Text(
                        //           '${'valid'.tr}: ',
                        //           style: textRegular.copyWith(
                        //             color: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyMedium!
                        //                 .color!
                        //                 .withOpacity(0.5),
                        //             fontSize: Dimensions.fontSizeExtraSmall,
                        //           ),
                        //         ),
                        //         Text(
                        //           DateConverter.isoDateTimeStringToDateOnly(
                        //               coupon.endDate!),
                        //           style: textRegular.copyWith(
                        //             color: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyMedium!
                        //                 .color!
                        //                 .withOpacity(0.5),
                        //             fontSize: Dimensions.fontSizeExtraSmall,
                        //           ),
                        //         ),
                        //       ]),
                        //
                        //     ]),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSize),
                  child: Image.asset(Images.dashLine),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.find<CouponController>()
                          .customerAppliedCoupon(coupon.id!, index);
                    },
                    child: couponController.couponModel!.data![index].isLoading
                        ? SpinKitCircle(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.50),
                            size: 30.0)
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeExtraSmall,
                              horizontal: Dimensions.paddingSizeSmall,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: couponController
                                      .couponModel!.data![index].isApplied!
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.15)
                                  : Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              couponController
                                      .couponModel!.data![index].isApplied!
                                  ? 'applied'.tr
                                  : 'apply'.tr,
                              textAlign: TextAlign.center,
                              style: textRegular.copyWith(
                                color: couponController
                                        .couponModel!.data![index].isApplied!
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            top: 50,
            left: -18,
            child: Container(
              width: 30,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.25)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: -18,
            child: Container(
              width: 30,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.25)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ]),
      );
    });
  }
}

class CouponDetailsBottomSheet extends StatelessWidget {
  final Coupon coupon;
  const CouponDetailsBottomSheet({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Dimensions.paddingSizeLarge),
            topLeft: Radius.circular(Dimensions.paddingSizeLarge),
          )),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Image.asset(
                  Images.crossIcon,
                  height: Dimensions.paddingSizeSmall,
                  width: Dimensions.paddingSizeSmall,
                  color: Theme.of(context).cardColor,
                ),
              )),
        ),
        Image.asset(
          Images.coupon,
          height: Dimensions.paddingSizeLarge,
          width: Dimensions.paddingSizeLarge,
        ),
        Row(mainAxisSize: MainAxisSize.min, children: [
          Text(coupon.couponCode ?? '', style: textBold),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: coupon.couponCode ?? ''));
              showCustomSnackBar('copied'.tr, isError: false);
            },
            child: Icon(
              Icons.copy,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
          )
        ]),
        Text(
          '${'valid_until'.tr} ${DateConverter.isoDateTimeStringToDateOnly(coupon.endDate ?? '')}',
          style: textRegular.copyWith(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          '${'get'.tr} ${coupon.amountType == 'percentage' ? '${coupon.coupon} %' : PriceConverter.convertPrice(double.parse(coupon.coupon ?? '0'))} ${'discount'.tr}',
          style: textRobotoBold,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(coupon.description ?? '', style: textRegular),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(0.15),
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.paddingSizeSmall)),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          margin: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault,
              horizontal: Dimensions.paddingSizeSmall),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            coupon.zoneCoupon!.contains('all')
                ? const SizedBox()
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      margin: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall),
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Colors.white
                            : Colors.black.withOpacity(0.50),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: '${'this_offer_available_only_in'.tr} ',
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                              children: [
                            TextSpan(
                              text: coupon.zoneCoupon!.contains('all')
                                  ? 'all_zone'.tr
                                  : coupon.zoneCoupon!.toString().substring(1,
                                      coupon.zoneCoupon!.toString().length - 1),
                              style: textSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall),
                            )
                          ])),
                    ),
                  ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            coupon.categoryCoupon!.contains('all')
                ? const SizedBox()
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      margin: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall),
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Colors.white
                            : Colors.black.withOpacity(0.50),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: '${'discount_on'.tr} ',
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                              children: [
                            TextSpan(
                              text: coupon.categoryCoupon!.contains('all')
                                  ? 'all'.tr
                                  : coupon.categoryCoupon!.toString().substring(
                                      1,
                                      coupon.categoryCoupon!.toString().length -
                                          1),
                              style: textSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall),
                            )
                          ])),
                    ),
                  ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Container(
                margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: '${'one_user_can_use_it_maximum'.tr} ',
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                        children: [
                      TextSpan(
                        text: '${coupon.limit} ${'times'.tr}',
                        style: textSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall),
                      )
                    ])),
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            coupon.customerLevelCoupon!.contains('all')
                ? const SizedBox()
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      margin: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall),
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Colors.white
                            : Colors.black.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: '${'to_get_this_offer_user'.tr} ',
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                              children: [
                            TextSpan(
                              text: coupon.customerLevelCoupon!
                                  .toString()
                                  .substring(
                                      1,
                                      coupon.customerLevelCoupon!
                                              .toString()
                                              .length -
                                          1),
                              style: textSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall),
                            )
                          ])),
                    ),
                  ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Container(
                margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: '${'you_need_to_spend_minimum'.tr} ',
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                        children: [
                      TextSpan(
                        text:
                            '${Get.find<ConfigController>().config!.currencySymbol}${coupon.minTripAmount}',
                        style: textSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall),
                      )
                    ])),
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            if (double.parse(coupon.maxCouponAmount ?? '0') > 0)
              Row(children: [
                Container(
                  margin:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                Expanded(
                  child: RichText(
                      text: TextSpan(
                          text: '${'maximum_discount'.tr} ',
                          style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          children: [
                        TextSpan(
                          text:
                              '${Get.find<ConfigController>().config!.currencySymbol}${coupon.maxCouponAmount}',
                          style: textSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                        )
                      ])),
                ),
              ]),
          ]),
        ),
      ]),
    );
  }
}
