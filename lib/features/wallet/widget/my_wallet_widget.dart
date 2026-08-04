import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/features/wallet/controllers/wallet_controller.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/util/animation_helper.dart';

class MyWalletWidget extends StatefulWidget {
  const MyWalletWidget({super.key});

  @override
  State<MyWalletWidget> createState() => _MyWalletWidgetState();
}

List<String> stateWallet = ['مدفوع للسائق', 'متلقاه من راكب'];

class _MyWalletWidgetState extends State<MyWalletWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<WalletController>(
      builder: (walletController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Add Money Button
              AnimationHelper.buttonAnimation(
                isVisible: true,
                child: _defaultIcon(
                  context,
                  text: 'add_money'.tr,
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    walletController.updateCurrentTabIndex(2);
                  },
                ),
              ),

              SizedBox(height: size.height * 0.02),

              /// Title
              AnimationHelper.titleAnimation(
                child: Text(
                  'تاريخ المعاملات',
                  style: textBold.copyWith(
                    color: Theme.of(context).textTheme.labelLarge!.color,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.015),

              /// History List
              _defaultViewHistoryWallet(Get.find<WalletController>()),
            ],
          ),
        );
      },
    );
  }

  Widget _defaultIcon(
    BuildContext context, {
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    var size = MediaQuery.of(context).size;

    return ButtonWidget(
      onPressed: onTap,
      buttonText: text,
      backgroundColor: color,
      width: size.width * 0.42,
      height: size.height * 0.045,
      radius: 50,
    );
  }
}

Widget _defaultViewHistoryWallet(WalletController controller) {
  return Column(
    children: List.generate(controller.transactionModel!.data!.length, (index) {
      return AnimationHelper.cardAnimation(
        index: index,
        child: _walletCard(index),
      );
    }),
  );
}

Widget _walletCard(int index) {
  return Builder(builder: (context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.width * 0.035,
      ),
      margin: EdgeInsets.symmetric(
        vertical: size.width * 0.02,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Left Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stateWallet[index],
                  style: textHeavy.copyWith(
                    color: Theme.of(context).textTheme.labelLarge!.color,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  'علي عبدالعزيز | 25 يناير 2023',
                  style: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.displayMedium!.color,
                  ),
                ),
              ],
            ),
          ),

          /// Price
          Text(
            '240 حنيه',
            style: textBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              color: _priceColor(index, context),
            ),
          ),
        ],
      ),
    );
  });
}

Color _priceColor(int index, BuildContext context) {
  if (stateWallet[index] == 'مدفوع للسائق') {
    return Theme.of(context).colorScheme.error;
  } else {
    return Theme.of(context).primaryColor;
  }
}
