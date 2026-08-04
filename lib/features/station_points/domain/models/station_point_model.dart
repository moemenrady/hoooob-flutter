import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationPointModel {
  final int id;
  final String name;
  final double lat;
  final double lng;
  final String address;

  StationPointModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory StationPointModel.fromJson(Map<String, dynamic> json) {
    return StationPointModel(
      id: json['id'],
      name: json['name'],
      lat: (json['latitude'] is String)
          ? double.parse(json['latitude'])
          : json['latitude'].toDouble(),
      lng: (json['longitude'] is String)
          ? double.parse(json['longitude'])
          : json['longitude'].toDouble(),
      address: json['address'] ?? '',
    );
  }

  LatLng get latLng => LatLng(lat, lng);
}