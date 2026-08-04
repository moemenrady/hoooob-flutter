import 'package:hoooob_app/interface/repository_interface.dart';

abstract class TripRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getTripList(String tripType, int offset, String from,
      String to, String filter, String status);
  Future<dynamic> getRideCancellationReasonList();
  Future<dynamic> getParcelCancellationReasonList();
  Future<dynamic> driverGetAllTripe();
  Future<dynamic> passengersGetAllTripe();
  Future<dynamic> startTrip(int tripId);
  Future<dynamic> endTrip(int tripId);
}
