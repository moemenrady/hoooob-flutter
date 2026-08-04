import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/image_widget.dart';
import 'package:hoooob_app/features/my_offer/domain/models/best_offer_model.dart';
import 'package:hoooob_app/helper/date_converter.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class DiscountCartWidget extends StatelessWidget {
  final OfferModel offerModel;
  const DiscountCartWidget({super.key, required this.offerModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: size.height * .14,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(.2),
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(1, 2),
            )
          ],
          color: Theme.of(context).cardColor,
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
          // border: Border.all(
          //   color: Theme.of(context).hintColor.withOpacity(.5),
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                child: ImageWidget(
                  image: offerModel.image!,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: Dimensions.paddingSize),
                      Text(offerModel.title ?? '',
                          style: Get.isDarkMode
                              ? textBold.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!)
                              : textHeavy,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        offerModel.shortDescription ?? '',
                        style: Get.isDarkMode
                            ? textRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.7))
                            : textRegular.copyWith(
                                color: Theme.of(context).hintColor),
                        overflow: TextOverflow.ellipsis,
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
  }
}
