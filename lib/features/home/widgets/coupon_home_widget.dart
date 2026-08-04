import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/coupon/controllers/coupon_controller.dart';
import 'package:hoooob_app/features/home/widgets/coupon_home_shimmer.dart';
import 'package:hoooob_app/features/my_offer/screens/my_offer_screen.dart';
import 'package:hoooob_app/helper/price_converter.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

import '../../../util/images.dart';

class HomeCouponWidget extends StatefulWidget {
  const HomeCouponWidget({super.key});

  @override
  State<HomeCouponWidget> createState() => _HomeCouponWidgetState();
}

class _HomeCouponWidgetState extends State<HomeCouponWidget> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<CouponController>(builder: (couponController) {
      return couponController.couponModel != null
          ? (couponController.couponModel!.data != null &&
                  couponController.couponModel!.data!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('discount_coupons'.tr,
                              style: textBold.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Get.isDarkMode
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.9)
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color)),
                          // InkWell(
                          //   onTap: () =>
                          //       Get.to(() => MyOfferScreen(isCoupon: true)),
                          //   child: Text('see_all'.tr,
                          //       style: textRegular.copyWith(
                          //         color: Get.isDarkMode
                          //             ? Theme.of(context).primaryColor
                          //             : Theme.of(context).hintColor,
                          //       )),
                          // ),
                        ]),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    SizedBox(
                      width: Get.width,
                      height: 125,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1,
                          disableCenter: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        ),
                        itemCount: couponController.couponModel!.data!.length,
                        itemBuilder: (context, index, _) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusDefault),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(.15),
                                  blurRadius: 1,
                                  offset: const Offset(1, 2),
                                )
                              ],
                            ),
                            child: Stack(children: [
                              InkWell(
                                onTap: () =>
                                    Get.to(() => MyOfferScreen(isCoupon: true)),
                                child: Container(
                                  height: size.height * .15,
                                  width: Get.width,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeExtraSmall,
                                    horizontal: Dimensions.paddingSizeLarge,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusDefault),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.25)),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
                                        const SizedBox(
                                            width: Dimensions.paddingSizeSmall),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  Text('Code: ',
                                                      style: textRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .color!)),
                                                  Text(
                                                      '${couponController.couponModel!.data![index].couponCode}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: Dimensions
                                                              .fontSizeLarge)),
                                                ]),
                                                const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: Dimensions
                                                          .paddingSizeExtraLarge,
                                                      top: Dimensions
                                                          .paddingSize),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${couponController.couponModel!.data![index].amountType == 'percentage' ? '${couponController.couponModel!.data![index].coupon.toString().split('.')[0]} %' : PriceConverter.convertPrice(double.parse(couponController.couponModel!.data![index].coupon ?? '0'))} '
                                                        // '${coupon.categoryCoupon!.contains('all') ? 'all_rides'.tr : coupon.categoryCoupon!.toString().substring(1, coupon.categoryCoupon!.toString().length - 1)}'
                                                        ,
                                                        style: textRobotoRegular
                                                            .copyWith(
                                                                color: Color(
                                                                    0xffE01B41),
                                                                fontSize: Dimensions
                                                                    .fontSizeOverLarge,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      couponController
                                                                  .couponModel!
                                                                  .data![index]
                                                                  .amountType ==
                                                              'percentage'
                                                          ? Text(
                                                              'off',
                                                              style: textRobotoRegular.copyWith(
                                                                  color: Color(
                                                                      0xffE01B41),
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeExtraLarge,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeSeven),
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
                                              horizontal:
                                                  Dimensions.paddingSize),
                                          child: Image.asset(Images.dashLine),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Get.find<CouponController>()
                                                  .customerAppliedCoupon(
                                                      couponController
                                                          .couponModel!
                                                          .data![index]
                                                          .id!,
                                                      index);
                                            },
                                            child: couponController.couponModel!
                                                    .data![index].isLoading
                                                ? SpinKitCircle(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.50),
                                                    size: 30.0)
                                                : Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: Dimensions
                                                          .paddingSizeExtraSmall,
                                                      horizontal: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: couponController
                                                              .couponModel!
                                                              .data![index]
                                                              .isApplied!
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(0.15)
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                    child: Text(
                                                      couponController
                                                              .couponModel!
                                                              .data![index]
                                                              .isApplied!
                                                          ? 'applied'.tr
                                                          : 'apply'.tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          textRegular.copyWith(
                                                        color: couponController
                                                                .couponModel!
                                                                .data![index]
                                                                .isApplied!
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Theme.of(context)
                                                                .cardColor,
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
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.25)),
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
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.25)),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    // SizedBox(
                    //   height: 14,
                    //   width: Get.width,
                    //   child: Center(
                    //     child: ListView.separated(
                    //       shrinkWrap: true,
                    //       padding: EdgeInsets.zero,
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: couponController.couponModel!.data!.length,
                    //       itemBuilder: (context, index) {
                    //         return Center(
                    //             child: Container(
                    //           height: 14,
                    //           width: 14,
                    //           decoration: BoxDecoration(
                    //               color: index == activeIndex
                    //                   ? Theme.of(context).primaryColor
                    //                   : Theme.of(context).hintColor,
                    //               borderRadius: BorderRadius.circular(100)),
                    //         ));
                    //       },
                    //       separatorBuilder: (context, index) {
                    //         return const Padding(
                    //             padding: EdgeInsets.only(
                    //                 right: Dimensions.iconSizeSmall));
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ]),
                )
              : const SizedBox()
          : const CouponHomeShimmer();
    });
  }
}
