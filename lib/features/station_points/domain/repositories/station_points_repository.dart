import 'package:hoooob_app/data/api_client.dart';
import 'package:hoooob_app/features/station_points/domain/models/station_point_model.dart';
import 'package:hoooob_app/features/station_points/domain/repositories/station_points_repository_interface.dart';
import 'package:hoooob_app/util/app_constants.dart';

class StationRepository implements StationRepositoryInterface {
  final ApiClient apiClient;

  StationRepository({required this.apiClient});

  @override
  Future<List<StationPointModel>> searchStations({
    String? query,
    double? lat,
    double? lng,
  }) async {
    final response = await apiClient.getData(
      AppConstants.carpoolStationSearch,
      query: {
        if (query != null && query.isNotEmpty) 'q': query,
        if (lat != null) 'lat': lat.toString(),
        if (lng != null) 'lng': lng.toString(),
      },
    );

    if (response.body is List) {
      return (response.body as List)
          .map((e) => StationPointModel.fromJson(e))
          .toList();
    }

    return [];
  }
}
