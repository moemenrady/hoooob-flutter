class ReservationTripeRequestModel {
  final int routeId;
  final int seatsCount;
  final double pickupLat;
  final double pickupLng;
  final double dropOffLat;
  final double dropOffLng;
  final int price;

  ReservationTripeRequestModel({
    required this.routeId,
    required this.seatsCount,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropOffLat,
    required this.dropOffLng,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'route_id': routeId,
      'seats_count': seatsCount,
      'pickup_lat': pickupLat,
      'pickup_lng': pickupLng,
      'dropoff_lat': dropOffLat,
      'dropoff_lng': dropOffLng,
      'fare': price,
    };
  }
}
