import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';

class DetailsTripeNavigateDataModel {
  final String? fromAddress;
  final String? toAddress;
  final dynamic startDate;
  final dynamic startTime;
  final int? requests;
  final int? price;
  final int? routeId;
  final String? carName;
  final int? seatsAvailable;
  final bool? isSmoking;
  final bool? isAc;
  final bool? isMusic;
  final bool? isBages;
  final int? mainAge;
  final int? maxAge;
  final String? driverName;
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  final List<Passenger>? passengersData;
  final double? pickupMatchLat;
  final double? pickupMatchLng;
  final String? pickupMatchAddress;

  DetailsTripeNavigateDataModel(
      {required this.fromAddress,
      required this.toAddress,
      required this.startDate,
      required this.startTime,
      required this.requests,
      required this.price,
      required this.carName,
      required this.seatsAvailable,
      required this.isSmoking,
      required this.isAc,
      required this.isMusic,
      required this.isBages,
      required this.mainAge,
      required this.maxAge,
      required this.routeId,
      required this.startLat,
      required this.startLng,
      required this.endLat,
      required this.endLng,
      required this.driverName,
      this.passengersData,
      this.pickupMatchLat,
      this.pickupMatchLng,
      this.pickupMatchAddress});
}
