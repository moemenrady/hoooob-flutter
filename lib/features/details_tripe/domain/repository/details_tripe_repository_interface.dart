import 'package:hoooob_app/features/details_tripe/domain/models/cancel_and_start_tripe_request.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/reservation_tripe_request_model.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_request_model.dart';

abstract class DetailsTripeRepositoryInterface  {
  Future<dynamic> reservationTripe(ReservationTripeRequestModel  reservationTripeRequestModel);
  Future<dynamic> cancelAndAcceptTripe(CancelAmdStartTripeRequestModel cancelAmdStartTripeRequestModel);

}