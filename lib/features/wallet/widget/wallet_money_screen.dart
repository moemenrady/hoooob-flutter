import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/wallet/widget/my_wallet_widget.dart';
import 'package:hoooob_app/features/wallet/widget/payment_method_widget.dart';
import 'package:hoooob_app/features/wallet/widget/transaction_card_widget.dart';
import 'package:hoooob_app/features/wallet/widget/wallet_money_amount_widget.dart';
import 'package:hoooob_app/features/wallet/widget/withdraw_money_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/features/notification/widgets/notification_shimmer.dart';
import 'package:hoooob_app/features/wallet/controllers/wallet_controller.dart';
import 'package:hoooob_app/features/wallet/widget/custom_title.dart';
import 'package:hoooob_app/common_widgets/no_data_widget.dart';
import 'package:hoooob_app/common_widgets/paginated_list_widget.dart';

class WalletMoneyScreen extends StatefulWidget {
  const WalletMoneyScreen({super.key});

  @override
  State<WalletMoneyScreen> createState() => _WalletMoneyScreenState();
}

class _WalletMoneyScreenState extends State<WalletMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController) {
      return SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTitle(
          title: 'wallet_money'.tr,
          color: Theme.of(context).textTheme.bodyMedium!.color!,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        const WalletMoneyAmountWidget(walletMoney: true),

        walletController.currentTabIndex == 1
            ? CustomTitle(
                title: 'payment_method'.tr,
                color: Theme.of(context).textTheme.bodyMedium!.color!,
                fontWeight: FontWeight.w700,
              )
            : SizedBox(height: 15,),
        // const SizedBox(height: Dimensions.paddingSizeDefault),
        // Fix: Wrap MyWalletWidget with Expanded to give it bounded height
        if (walletController.currentTabIndex == 0) MyWalletWidget(),
        // if (walletController.currentTabIndex == 1) WithdrawMoneyWidget(),
        if (walletController.currentTabIndex == 2) PaymentMethodWidget()
      ]));
    });
  }
}
