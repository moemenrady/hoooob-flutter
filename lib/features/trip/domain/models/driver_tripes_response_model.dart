class DriverTripsResponseModel {
  String responseCode;
  String message;
  List<DriverTrip> data;

  DriverTripsResponseModel({
    required this.responseCode,
    required this.message,
    required this.data,
  });

  factory DriverTripsResponseModel.fromJson(Map<String, dynamic> json) {
    return DriverTripsResponseModel(
      responseCode: json['response_code'],
      message: json['message'],
      data: json['data'] != null
          ? List<DriverTrip>.from(
              json['data'].map((x) => DriverTrip.fromJson(x)))
          : [],
    );
  }
}

class DriverTrip {
  String name;
  String? profileImage;
  int seats;
  bool isSmokingAllowed;
  bool isAc;
  String allowedGender;
  int? allowedAgeMin; // ممكن تكون null
  int? allowedAgeMax; // ممكن تكون null
  bool hasScreenEntertainment;
  bool hasMusic;
  bool allowLuggage;
  String startDay;
  String startHour;
  String startAddress;
  String endAddress;
  String vehicleName;
  int passengersCount;
  int routeId;
  List<Passenger> passengers;
  bool isStart; // Added for trip status
  String? endTime; // Added for trip status
  List<double>? startCoordinates; // Added for map coordinates
  List<double>? endCoordinates; // Added for map coordinates
  String? encodedPolyline; // Added for route polyline

  DriverTrip({
    required this.name,
    this.profileImage,
    required this.seats,
    required this.isSmokingAllowed,
    required this.isAc,
    required this.allowedGender,
    this.allowedAgeMin,
    this.allowedAgeMax,
    required this.hasScreenEntertainment,
    required this.hasMusic,
    required this.allowLuggage,
    required this.startDay,
    required this.startHour,
    required this.startAddress,
    required this.endAddress,
    required this.vehicleName,
    required this.passengersCount,
    required this.passengers,
    required this.routeId,
    required this.isStart,
    this.endTime,
    this.startCoordinates,
    this.endCoordinates,
    this.encodedPolyline,
  });

  factory DriverTrip.fromJson(Map<String, dynamic> json) {
    return DriverTrip(
      name: json['name'],
      routeId: json['route_id'],
      profileImage: json['profile_image'],
      seats: json['seats'] ?? 0,
      isSmokingAllowed: json['is_smoking_allowed'],
      isAc: json['is_ac'],
      allowedGender: json['allowed_gender'],
      allowedAgeMin: json['allowed_age_min'] ?? 0,
      allowedAgeMax: json['allowed_age_max'] ?? 0,
      hasScreenEntertainment: json['has_screen_entertainment'],
      hasMusic: json['has_music'],
      allowLuggage: json['allow_luggage'],
      startDay: json['start_day'],
      startHour: json['start_hour'],
      startAddress: json['start_address'],
      endAddress: json['end_address'],
      vehicleName: json['vehicle_name'],
      passengersCount: json['passengers_count'],
      passengers: json['passengers'] != null
          ? List<Passenger>.from(
              json['passengers'].map((x) => Passenger.fromJson(x)))
          : [],
      isStart: json['is_start'] ?? false, // Added for trip status
      endTime: json['end_time'], // Added for trip status
      startCoordinates: json['start_coordinates'] != null
          ? List<double>.from(json['start_coordinates'])
          : null, // Added for map coordinates
      endCoordinates: json['end_coordinates'] != null
          ? List<double>.from(json['end_coordinates'])
          : null, // Added for map coordinates
      encodedPolyline: json['encoded_polyline'], // Added for route polyline
    );
  }
}

class Passenger {
  String name;
  int passengerId;
  String pickupAddress;
  String dropoffAddress;
  int seatsCount;
  int fare;
  String? image;

  Passenger({
    required this.name,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.seatsCount,
    required this.fare,
    required this.passengerId,
    this.image,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      name: json['name'],
      pickupAddress: json['pickup_address'],
      dropoffAddress: json['dropoff_address'],
      seatsCount: json['seats_count'],
      fare: json['fare'],
      image: json['profile_image'],
      passengerId: json['passenger_id'],
    );
  }
}
