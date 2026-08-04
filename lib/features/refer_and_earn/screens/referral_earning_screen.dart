import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/no_data_widget.dart';
import 'package:hoooob_app/common_widgets/paginated_list_widget.dart';
import 'package:hoooob_app/features/notification/widgets/notification_shimmer.dart';
import 'package:hoooob_app/features/profile/controllers/profile_controller.dart';
import 'package:hoooob_app/features/refer_and_earn/controllers/refer_and_earn_controller.dart';
import 'package:hoooob_app/features/refer_and_earn/widgets/earning_cart_widget.dart';
import 'package:hoooob_app/features/wallet/widget/custom_title.dart';
import 'package:hoooob_app/helper/price_converter.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class ReferralEarningScreen extends StatelessWidget {
  const ReferralEarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeSmall,
          horizontal: Dimensions.paddingSizeDefault),
      child:
          GetBuilder<ReferAndEarnController>(builder: (referAndEarnController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('your_earning'.tr,
              style: textRegular.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Get.isDarkMode
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.9)
                      : null)),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Container(
            height: size.height * .13,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeDefault),
                color: Theme.of(context).cardColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2)),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.ranking, height: 40, width: 40),
                  const SizedBox(
                    width: Dimensions.paddingSizeExtraLarge,
                  ),
                  Text(
                      PriceConverter.convertPrice(Get.find<ProfileController>()
                              .profileModel
                              ?.data
                              ?.wallet
                              ?.referralEarn ??
                          0),
                      style: textRobotoBold.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900)),
                ]),
          ),
          CustomTitle(
              title: 'earning_history'.tr,
              color: Theme.of(context).textTheme.bodyMedium!.color!),
          Divider(
              thickness: .25,
              color: Theme.of(context).primaryColor.withOpacity(0.25)),
          referAndEarnController.referralModel?.data != null
              ? (referAndEarnController.referralModel!.data!.isNotEmpty)
                  ? Expanded(
                      child: SingleChildScrollView(
                      controller: referAndEarnController.scrollController,
                      child: PaginatedListWidget(
                        scrollController:
                            referAndEarnController.scrollController,
                        totalSize:
                            referAndEarnController.referralModel!.totalSize,
                        offset: (referAndEarnController.referralModel?.offset !=
                                null)
                            ? int.parse(referAndEarnController
                                .referralModel!.offset
                                .toString())
                            : null,
                        onPaginate: (int? offset) async {
                          await referAndEarnController
                              .getEarningHistoryList(offset!);
                        },
                        itemView: ListView.builder(
                          itemCount: referAndEarnController
                              .referralModel!.data!.length,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return EarningCartWidget(
                                transaction: referAndEarnController
                                    .referralModel!.data![index]);
                          },
                        ),
                      ),
                    ))
                  : const Expanded(
                      child: NoDataWidget(title: 'no_transaction_found'))
              : const Expanded(child: NotificationShimmer()),
        ]);
      }),
    );
  }
}
