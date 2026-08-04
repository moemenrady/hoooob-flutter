import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/features/station_points/domain/models/station_point_model.dart';

abstract class StationServiceInterface {
  Future<List<StationPointModel>> searchStations({
    String? query,
    LatLng? currentPosition,
  });
  
}
