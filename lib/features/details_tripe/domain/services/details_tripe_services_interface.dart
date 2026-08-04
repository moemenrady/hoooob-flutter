import 'package:get/get.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/cancel_and_start_tripe_request.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/reservation_tripe_request_model.dart';

abstract class DetailsTripeServiceInterface {
  Future<dynamic> reservationTripe(ReservationTripeRequestModel  reservationTripeRequestModel);
  Future<dynamic> cancelAndAcceptTripe(CancelAmdStartTripeRequestModel cancelAmdStartTripeRequestModel);
}
