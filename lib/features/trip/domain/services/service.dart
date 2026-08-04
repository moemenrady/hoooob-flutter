import 'package:hoooob_app/features/trip/domain/repositories/trip_repository_interface.dart';
import 'package:hoooob_app/features/trip/domain/services/service_interface.dart';

class TripService implements TripServiceInterface {
  TripRepositoryInterface tripRepositoryInterface;
  TripService({required this.tripRepositoryInterface});

  @override
  Future getTripList(String tripType, int offset, String from, String to,
      String filter, String status) async {
    return await tripRepositoryInterface.getTripList(
        tripType, offset, from, to, filter, status);
  }

  @override
  Future getRideCancellationReasonList() async {
    return await tripRepositoryInterface.getRideCancellationReasonList();
  }

  @override
  Future getParcelCancellationReasonList() async {
    return await tripRepositoryInterface.getParcelCancellationReasonList();
  }

  @override
  Future driverGetAllTripe() async {
    return await tripRepositoryInterface.driverGetAllTripe();
  }

  @override
  Future passengersGetAllTripe() async {
    return await tripRepositoryInterface.passengersGetAllTripe();
  }

  @override
  Future startTrip(int tripId) async {
    return await tripRepositoryInterface.startTrip(tripId);
  }

  @override
  Future endTrip(int tripId) async {
    return await tripRepositoryInterface.endTrip(tripId);
  }
}
