import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_name_and_price_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class SearchTripeShimmerEffect extends StatelessWidget {
  const SearchTripeShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[50]!,
            child: Container(
              height: size.height * 0.3 - 25,
              width: size.width * 0.90,
              margin:
                  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraLarge,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: const Offset(15, 0),
                  )
                ],
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
            ),
          );
        });
  }
}
