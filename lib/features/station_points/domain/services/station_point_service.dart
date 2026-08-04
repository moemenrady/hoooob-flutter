import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/features/station_points/domain/models/station_point_model.dart';
import 'package:hoooob_app/features/station_points/domain/repositories/station_points_repository_interface.dart';
import 'package:hoooob_app/features/station_points/domain/services/station_point_service_interface.dart';



class StationService implements StationServiceInterface {
  final StationRepositoryInterface stationRepository;

  StationService({required this.stationRepository});

  @override
  Future<List<StationPointModel>> searchStations({
    String? query,
    LatLng? currentPosition,
  }) {
    return stationRepository.searchStations(
      query: query,
      lat: currentPosition?.latitude,
      lng: currentPosition?.longitude,
    );
  }
}