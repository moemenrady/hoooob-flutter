import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/home/controllers/search_tripe_controller.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class SearchTripsTextFromToWidgets extends StatelessWidget {
  final List<SearchTripeAll> tripeData;
  final int index;

  const SearchTripsTextFromToWidgets({super.key, required this.tripeData, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<SearchTripeController>(builder: (searchTripeController) {
      return SizedBox(
        width: size.width * 0.4 + 3,
        child: Column(
          spacing: size.height * 0.01,
          children: [
            _defaultText(
              text: tripeData[index].pickupAddress.toString(),
              fontSize: Dimensions.fontSizeDefault,
              context: context,
            ),
            _defaultText(
              text: tripeData[index].dropoffAddress.toString(),
              fontSize: Dimensions.fontSizeDefault,
              context: context,
            ),
          ],
        ),
      );
    });
  }

  Widget _defaultText({
    required String text,
    Color? color,
    required double fontSize,
    required BuildContext context,
  }) {
    return Text(text,
        maxLines: 2,
        textAlign: TextAlign.end,
        style: textSemiBold.copyWith(
          color: color ?? Theme.of(context).textTheme.bodyMedium!.color!,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ));
  }
}
