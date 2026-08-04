import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/details_tripe/screens/details_trips_screen.dart';
import 'package:hoooob_app/features/home/controllers/search_tripe_controller.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_details_widget.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_name_and_price_widget.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_name_car_nad_icon_widget.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_search_date_widget.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_trips_from_to_and_time_widgets.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_trips_text_from_to_widgets.dart';
import 'package:hoooob_app/util/dimensions.dart';

class SearchTripeItemWidget extends StatelessWidget {
  final List<SearchTripeAll> data;
  final int index;

  const SearchTripeItemWidget(
      {super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<SearchTripeController>(builder: (searchTripeController) {
      var tripe = data[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsTripScreen(
                  isUserTrip: false,
                  tripeData: DetailsTripeNavigateDataModel(
                    fromAddress: tripe.pickupAddress,
                    toAddress: tripe.dropoffAddress,
                    startDate: tripe.startTime,
                    startTime: tripe.startTime,
                    requests: 0,
                    price: tripe.price?.toInt() ?? 0,
                    carName: tripe.vehicle?.brand ?? '',
                    seatsAvailable: tripe.seatsAvailable,
                    isSmoking: tripe.isSmokingAllowed,
                    isAc: tripe.isAc,
                    isMusic: tripe.hasMusic,
                    isBages: tripe.allowLuggage,
                    mainAge: tripe.allowedAgeMin,
                    maxAge: tripe.allowedAgeMax,
                    routeId: tripe.routeId,
                    startLat: tripe.pickupMatchPoint?.lat ?? 0.0,
                    startLng: tripe.pickupMatchPoint?.lng ?? 0.0,
                    endLat: tripe.dropoffMatchPoint?.lat ?? 0.0,
                    endLng: tripe.dropoffMatchPoint?.lng ?? 0.0,
                    driverName: tripe.driver?.fullName.toString() ?? '',
                    pickupMatchLat: tripe.pickupMatchPoint?.lat,
                    pickupMatchLng: tripe.pickupMatchPoint?.lng,
                    pickupMatchAddress: tripe.pickupAddress,
                  ),
                ),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: size.height * 0.02),
            SearchTripeSearchDateWidget(),
            Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SearchTripeNameAndPriceWidget(
                        tripeData: data, index: index),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SearchTripsTextFromToWidgets(
                            tripeData: data, index: index),
                        SizedBox(width: size.height * 0.01),
                        SearchTripsFromToAndTextWidgets(),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SearchTripeNameCarNadIconWidget(
                        tripeData: data, index: index),
                    SizedBox(height: size.height * 0.01),
                    SearchTripeDetailsWidget(tripeData: data, index: index),
                  ],
                )),
          ],
        ),
      );
    });
  }
}
