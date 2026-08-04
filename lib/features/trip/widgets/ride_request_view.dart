import 'package:flutter/material.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';
import 'package:hoooob_app/features/trip/widgets/ride_request_item.dart';

class RideRequestView extends StatelessWidget {
  final List<Passenger>passenger;
  const RideRequestView({super.key, required this.passenger});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: passenger.length,
        itemBuilder: (context, index) {
          return RideRequestItem(passenger:passenger ,index: index,);
        });
  }
}
