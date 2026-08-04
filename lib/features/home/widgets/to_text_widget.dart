
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class ToTextWidget extends StatelessWidget {
  const ToTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.fontSizeLarge,
      ),
      child: Text(
        'to'.tr,
        style: textRegular.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context)
                .primaryColorDark),
      ),
    );
  }
}