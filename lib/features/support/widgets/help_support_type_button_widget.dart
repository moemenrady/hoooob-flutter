import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/support/controllers/help_support_controller.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class HelpSupportTypeButtonWidget extends StatelessWidget {
  final int index;
  final String profileTypeName;
  const HelpSupportTypeButtonWidget(
      {super.key, required this.index, required this.profileTypeName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpSupportController>(builder: (supportController) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall),
        child: InkWell(
          onTap: () => supportController.updateCurrentTabIndex(index),
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: index == supportController.currentTabIndex
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).hintColor.withOpacity(.2),
              borderRadius:
                  BorderRadius.circular(Dimensions.paddingSizeDefault),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    profileTypeName.tr,
                    textAlign: TextAlign.center,
                    style: textSemiBold.copyWith(
                        color: index == supportController.currentTabIndex
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
