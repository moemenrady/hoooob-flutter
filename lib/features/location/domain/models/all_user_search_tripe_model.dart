class AllUserSearchTripeModel {
  final String responseCode;
  final String message;
  final int? totalSize;
  final int? limit;
  final int? offset;
  final List<TripeData> data;
  final List<dynamic> errors;

  AllUserSearchTripeModel({
    required this.responseCode,
    required this.message,
    this.totalSize,
    this.limit,
    this.offset,
    required this.data,
    required this.errors,
  });

  factory AllUserSearchTripeModel.fromJson(Map<String, dynamic> json) {
    return AllUserSearchTripeModel(
      responseCode: json['response_code'],
      message: json['message'],
      totalSize: json['total_size'],
      limit: json['limit'],
      offset: json['offset'],
      data:
          List<TripeData>.from(json['data'].map((x) => TripeData.fromJson(x))),
      errors: json['errors'] ?? [],
    );
  }
}

class TripeData {
  final String tripRequestId;
  final TripeDetails tripeDetails;
  final TripePickUp pickUp;
  final TripeDropOff dropOff;

  TripeData({
    required this.tripRequestId,
    required this.tripeDetails,
    required this.pickUp,
    required this.dropOff,
  });

  factory TripeData.fromJson(Map<String, dynamic> json) {
    return TripeData(
      tripRequestId: json["trip_request_id"],
      tripeDetails: TripeDetails.fromJson(json["driver"]),
      pickUp: TripePickUp.fromJson(json["pickup_match_point"]),
      dropOff: TripeDropOff.fromJson(json["dropoff_match_point"]),
    );
  }
}

class TripeDetails {
  final String nameDriver;
  final String gender;
  final String image;
  final int priceTripe;
  final String fromTime;
  final String toTime;
  final String nameCar;
  final bool airConditioner;
  final bool smokingAllowed;
  final bool numberOfSeats;

  TripeDetails({
    required this.nameDriver,
    required this.gender,
    required this.image,
    required this.priceTripe,
    required this.fromTime,
    required this.toTime,
    required this.nameCar,
    required this.airConditioner,
    required this.smokingAllowed,
    required this.numberOfSeats,
  });

  factory TripeDetails.fromJson(Map<String, dynamic> json) {
    return TripeDetails(
      nameDriver: json["full_name"],
      gender: json["gender"],
      image: json["profile_image"],
      priceTripe: json["price_tripe"],
      fromTime: json["from_time"],
      toTime: json["to_time"],
      nameCar: json["car_name"],
      airConditioner: json["air_conditioner"],
      smokingAllowed: json["smoking_allowed"],
      numberOfSeats: json["number_of_seats"],
    );
  }
}

class TripePickUp {
  final double lat;
  final double lng;
  final String address;

  TripePickUp({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory TripePickUp.fromJson(Map<String, dynamic> json) {
    return TripePickUp(
      lat: json["lat"],
      lng: json["lng"],
      address: json["address"],
    );
  }
}

class TripeDropOff {
  final double lat;
  final double lng;
  final String address;

  TripeDropOff({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory TripeDropOff.fromJson(Map<String, dynamic> json) {
    return TripeDropOff(
      lat: json["lat"],
      lng: json["lng"],
      address: json["address"],
    );
  }
}
