import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/trip/screens/ride_requests_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class DetailsTripeAllRequest extends StatelessWidget {
  final DetailsTripeNavigateDataModel tripeData;

  const DetailsTripeAllRequest({super.key, required this.tripeData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RideRequestsScreen(
              passenger: tripeData.passengersData!,
            ),
          ),
        );
      },
      child: Container(
        height: size.height * 0.06 + 5,
        width: size.width * 0.90,
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02 + 3),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withValues(alpha: 0.2),
              blurRadius: 25,
              spreadRadius: 1,
              offset: const Offset(1, 5),
            )
          ],
          color: Get.isDarkMode
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        ),
        child: Row(
          children: [
            // Text(
            //   textDirection: TextDirection.rtl,
            //   '55 جنيه',
            //   style: textBold.copyWith(
            //       fontSize: Dimensions.fontSizeExtraLarge,
            //       color: Theme.of(context).primaryColor),
            // ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.error,
              child: Center(
                child: Text(
                  tripeData.requests.toString(),
                  style: textBold.copyWith(color: Colors.white),
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  'passengers_requests'.tr,
                  style:
                      textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Image.asset(
                  Images.car,
                  width: size.width * 0.06,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
