import 'package:hoooob_app/features/station_points/domain/models/station_point_model.dart';

abstract class StationRepositoryInterface {
  Future<List<StationPointModel>> searchStations({
    String? query,
    double? lat,
    double? lng,
  });
}

