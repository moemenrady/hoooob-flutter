class UserSearchTripeModel {
  final double pickupLat;
  final double pickupLng;
  final double dropOffLat;
  final double dropOffLng;
  final String gender;

  UserSearchTripeModel({
    required this.pickupLat,
    required this.pickupLng,
    required this.dropOffLat,
    required this.dropOffLng,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['pickup_lat'] = pickupLat;
    data['pickup_lng'] = pickupLng;
    data['dropoff_lat'] = dropOffLat;
    data['dropoff_lng'] = dropOffLng;
    data['gender'] = gender;
    return data;
  }
}
