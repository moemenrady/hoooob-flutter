import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class SearchTripeDetailsTextWidgets extends StatelessWidget {
  const SearchTripeDetailsTextWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('details_tripe'.tr,style:
    textBold.copyWith(
      fontSize: Dimensions.fontSizeDefault,
      color: Theme.of(context).textTheme.bodyMedium!.color,
    ));
  }
}
