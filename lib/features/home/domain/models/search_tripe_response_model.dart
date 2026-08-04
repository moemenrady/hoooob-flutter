class SearchTripeResponseModel {
  final List<SearchTripeAll>? data;
  final String? startAddress;
  final String? endAddress;

  SearchTripeResponseModel({
    this.data,
    this.startAddress,
    this.endAddress,
  });

  factory SearchTripeResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchTripeResponseModel(
      data: (json['data'] as List?)
          ?.map((e) => SearchTripeAll.fromJson(e))
          .toList(),
      startAddress: json['pickup_address'],
      endAddress: json['dropoff_address'],
    );
  }
}

class SearchTripeAll {
  final int? routeId;
  final Driver? driver;
  final Vehicle? vehicle;
  final String? category;
  final DateTime? startTime;
  final int? seatsAvailable;
  final bool? isAc;
  final bool? isSmokingAllowed;
  final MatchPoint? pickupMatchPoint;
  final MatchPoint? dropoffMatchPoint;
  final String? pickupAddress;
  final String? dropoffAddress;
  final num? price;
  final bool? hasMusic;
  final bool? hasScreenEntertainment;
  final bool? allowLuggage;
  final String? allowedGender;
  final int? allowedAgeMin;
  final int? allowedAgeMax;

  SearchTripeAll({
    this.routeId,
    this.driver,
    this.vehicle,
    this.category,
    this.startTime,
    this.seatsAvailable,
    this.isAc,
    this.isSmokingAllowed,
    this.pickupMatchPoint,
    this.dropoffMatchPoint,
    this.pickupAddress,
    this.dropoffAddress,
    this.price,
    this.hasMusic,
    this.hasScreenEntertainment,
    this.allowLuggage,
    this.allowedGender,
    this.allowedAgeMin,
    this.allowedAgeMax,
  });

  factory SearchTripeAll.fromJson(Map<String, dynamic> json) {
    return SearchTripeAll(
      routeId: json['route_id'],
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      vehicle:
          json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
      category: json['category'],
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      // ✅ التحويل هنا
      seatsAvailable: json['seats_available'],
      isAc: json['is_ac'],
      isSmokingAllowed: json['is_smoking_allowed'],
      pickupMatchPoint: json['pickup_match_point'] != null
          ? MatchPoint.fromJson(json['pickup_match_point'])
          : null,
      dropoffMatchPoint: json['dropoff_match_point'] != null
          ? MatchPoint.fromJson(json['dropoff_match_point'])
          : null,
      pickupAddress: json['pickup_address'],
      dropoffAddress: json['dropoff_address'],
      price: json['price'],
      hasMusic: json['has_music'],
      hasScreenEntertainment: json['has_screen_entertainment'],
      allowLuggage: json['allow_luggage'],
      allowedGender: json['allowed_gender'],
      allowedAgeMin: json['allowed_age_min'],
      allowedAgeMax: json['allowed_age_max'],
    );
  }
}

class Driver {
  final String? id;
  final String? fullName;
  final String? gender;
  final String? profileImage;

  Driver({
    this.id,
    this.fullName,
    this.gender,
    this.profileImage,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      fullName: json['full_name'],
      gender: json['gender'],
      profileImage: json['profile_image'],
    );
  }
}

class Vehicle {
  final String? brand;
  final String? model;
  final String? plateNumber;

  Vehicle({
    this.brand,
    this.model,
    this.plateNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      brand: json['brand'],
      model: json['model'],
      plateNumber: json['plate_number'],
    );
  }
}

class MatchPoint {
  final double? lat;
  final double? lng;

  MatchPoint({
    this.lat,
    this.lng,
  });

  factory MatchPoint.fromJson(Map<String, dynamic> json) {
    return MatchPoint(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}
