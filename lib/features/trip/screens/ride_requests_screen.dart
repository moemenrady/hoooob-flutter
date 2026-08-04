import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';
import 'package:hoooob_app/features/trip/widgets/ride_request_view.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class RideRequestsScreen extends StatelessWidget {
  final List<Passenger>passenger;
  const RideRequestsScreen({super.key, required this.passenger});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
          appBar: AppBarWidget(title: ''),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10,),
                Text(
                  'ride_requests'.tr,
                  style: textBold.copyWith(fontSize: 20),
                ),
                Expanded(child: RideRequestView(passenger: passenger,)),
              ],
            ),
          )),
    );
  }
}
