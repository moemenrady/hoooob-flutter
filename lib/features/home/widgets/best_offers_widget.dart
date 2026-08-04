import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/image_widget.dart';
import 'package:hoooob_app/features/my_offer/controller/offer_controller.dart';
import 'package:hoooob_app/features/my_offer/screens/discount_screen.dart';
import 'package:hoooob_app/features/my_offer/screens/my_offer_screen.dart';
import 'package:hoooob_app/features/my_offer/widgets/best_offer_shimmer_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class BestOfferWidget extends StatefulWidget {
  const BestOfferWidget({super.key});

  @override
  State<BestOfferWidget> createState() => _BestOfferWidgetState();
}

class _BestOfferWidgetState extends State<BestOfferWidget> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<OfferController>(builder: (offerController) {
      return offerController.bestOfferModel != null
          ? (offerController.bestOfferModel!.data != null &&
                  offerController.bestOfferModel!.data!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingSize,
                    bottom: Dimensions.paddingSizeSmall,
                    top: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.paddingSizeSmall),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'best_offer'.tr,
                              style: textBold.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!),
                            ),
                            InkWell(
                              onTap: () => Get.to(() => MyOfferScreen()),
                              child: Text(
                                'see_all'.tr,
                                style: textRegular.copyWith(
                                  color: Get.isDarkMode
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radiusDefault)),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.3),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: const Offset(1, 2),
                            )
                          ]),
                      child: SizedBox(
                        width: Get.width,
                        height: 130,
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
                          itemCount:
                              offerController.bestOfferModel!.data!.length,
                          itemBuilder: (context, index, _) {
                            return InkWell(
                              onTap: () => Get.to(() => DiscountScreen(
                                  offerModel: offerController
                                      .bestOfferModel!.data![index])),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusDefault),
                                            child: ImageWidget(
                                              image: offerController
                                                  .bestOfferModel!
                                                  .data![index]
                                                  .image!,
                                              fit: BoxFit.contain,
                                              height: size.height * .1,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            width: Get.width * 0.8,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSize),
                                                  Text(
                                                      offerController
                                                              .bestOfferModel!
                                                              .data![index]
                                                              .title ??
                                                          '',
                                                      style: Get.isDarkMode
                                                          ? textBold.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .color!)
                                                          : textHeavy,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeExtraSmall),
                                                  Text(
                                                    offerController
                                                            .bestOfferModel!
                                                            .data![index]
                                                            .shortDescription ??
                                                        '',
                                                    style: Get.isDarkMode
                                                        ? textRegular.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .color!
                                                                .withOpacity(
                                                                    0.7))
                                                        : textRegular.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  // const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                                  // Text(
                                                  //   '${'valid'.tr}: ${DateConverter.stringToLocalDateOnly(offerModel.endDate!)}',
                                                  //   style: Get.isDarkMode
                                                  //       ? textRegular.copyWith(
                                                  //           color: Theme.of(context)
                                                  //               .textTheme
                                                  //               .bodyMedium!
                                                  //               .color!
                                                  //               .withOpacity(0.7))
                                                  //       : textRegular.copyWith(
                                                  //           color: Theme.of(context).hintColor),
                                                  //   overflow: TextOverflow.ellipsis,
                                                  // ),
                                                ]),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    SizedBox(
                      height: 14,
                      width: Get.width,
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              offerController.bestOfferModel!.data!.length,
                          itemBuilder: (context, index) {
                            return Center(
                                child: Container(
                              height: 14,
                              width: 14,
                              decoration: BoxDecoration(
                                  color: index == activeIndex
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).hintColor,
                                  borderRadius: BorderRadius.circular(100)),
                            ));
                          },
                          separatorBuilder: (context, index) {
                            return const Padding(
                                padding: EdgeInsets.only(
                                    right: Dimensions.iconSizeSmall));
                          },
                        ),
                      ),
                    )
                  ]),
                )
              : const SizedBox()
          : const MyOfferShimmerWidget();
    });
  }
}
