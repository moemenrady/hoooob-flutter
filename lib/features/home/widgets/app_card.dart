import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/util/dimensions.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  const AppCard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(1, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
        color: Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white,
      ),
      child: child,
    );
  }
}
