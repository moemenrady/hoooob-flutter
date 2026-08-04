import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shimmer/shimmer.dart';

class TripeShimmerEffectWidget extends StatefulWidget {
  const TripeShimmerEffectWidget({super.key});

  @override
  State<TripeShimmerEffectWidget> createState() => _TripeShimmerEffectWidgetState();
}

class _TripeShimmerEffectWidgetState extends State<TripeShimmerEffectWidget> {
  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
    return  ListView.builder(
        itemCount:3 ,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: 5),
                width: size.width,
                height: size.height * 0.15 - 3,
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.01, vertical: size.height * 0.01),
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hintColor.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(1, 5),
                    )
                  ],
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        });
  }
}
