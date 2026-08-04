import 'package:flutter/material.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_all_details_widget.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_all_request.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_all_users_request.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_reservation_tripe_button.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_end_trip_button.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_start_trip_button.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_from_to_widget.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_name_car_and_price.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_search_date_widget.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';

class DetailsTripScreen extends StatelessWidget {
  final bool isUserTrip;
  final DetailsTripeNavigateDataModel tripeData;

  const DetailsTripScreen({
    super.key,
    required this.isUserTrip,
    required this.tripeData,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: [
          BodyWidget(
            appBar: AppBarWidget(
              title: '',
              showBackButton: false,
            ),
            body: SafeArea(
                child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    spacing: size.height * 0.02,
                    children: [
                      DetailsTripeSearchDateWidget(
                        tripeData: tripeData,
                      ),
                      DetailsTripeFromToWidget(
                        tripeData: tripeData,
                        isUserTripe: isUserTrip,
                      ),
                      isUserTrip
                          ? DetailsTripeAllRequest(tripeData: tripeData)
                          : SizedBox.shrink(),
                      DetailsTripeNameCarAndPrice(tripeData: tripeData),
                      DetailsTripeAllDetailsWidget(
                        tripeData: tripeData,
                      ),
                      isUserTrip
                          ? DetailsTripeAllUsersRequest(tripeData: tripeData)
                          : SizedBox.shrink(),
                      isUserTrip
                          ? DetailsTripeStartTripButton(
                              routeId: tripeData.routeId!)
                          : isUserTrip
                              ? DetailsTripeEndTripButton(
                                  routeId: tripeData.routeId!)
                              : DetailsTripeReservationButton(
                                  tripeData: tripeData,
                                ),
                    ],
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
