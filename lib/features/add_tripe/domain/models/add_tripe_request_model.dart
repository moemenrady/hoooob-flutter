class AddTripeRequestModel {
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;
  final String startTime;
  final int price;

// final String rideType;
  final String vehicleId;
  final int seatsAvailable;
  final int isAc;
  final int isSmokingAllowed;
  final int hasMusic;
  final int isMovies;
  final int allowLuggage;
  final String gender;
  final int allowedAgeMax;
  final int allowedAgeMin;
  final List<Map<String, dynamic>> restStops;
  final String encodedPolyline;

  AddTripeRequestModel({
    required this.startLat,
    required this.endLat,
    required this.startLng,
    required this.endLng,
    required this.startTime,
    // required this.rideType,
    required this.vehicleId,
    required this.seatsAvailable,
    required this.isAc,
    required this.isSmokingAllowed,
    required this.hasMusic,
    required this.isMovies,
    required this.allowLuggage,
    required this.gender,
    required this.allowedAgeMax,
    required this.price,
    required this.allowedAgeMin,
    required this.restStops,
    required this.encodedPolyline,
  });

  Map<String, dynamic> toJson() => {
        "start_lat": startLat,
        "start_lng": startLng,
        "end_lat": endLat,
        "end_lng": endLng,
        "start_time": startTime,
        // "rideType":rideType,
        "vehicle_id": vehicleId,
        "seats_available": seatsAvailable,
        "is_ac": isAc,
        "is_smoking_allowed": isSmokingAllowed,
        "has_music": hasMusic,
        "has_screen_entertainment": isMovies,
        "allow_luggage": allowLuggage,
        "allowed_gender": gender,
        "allowed_age_max": allowedAgeMax,
        "allowed_age_min": allowedAgeMin,
        "price": price,
        "rest_stops": restStops,
        "encoded_polyline": encodedPolyline
      };
}
