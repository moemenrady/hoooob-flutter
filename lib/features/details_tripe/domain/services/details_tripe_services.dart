import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/add_tripe/domain/repository/add_tripe_repository_interface.dart';
import 'package:hoooob_app/features/add_tripe/domain/services/add_tripe_services_interface.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/cancel_and_start_tripe_request.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/reservation_tripe_request_model.dart';
import 'package:hoooob_app/features/details_tripe/domain/repository/details_tripe_repository_interface.dart';
import 'package:hoooob_app/features/details_tripe/domain/services/details_tripe_services_interface.dart';

class DetailsTripeService implements DetailsTripeServiceInterface {
  final DetailsTripeRepositoryInterface addTripeRepositoryInterface;

  DetailsTripeService({required this.addTripeRepositoryInterface});

  @override
  Future<dynamic> reservationTripe(
      ReservationTripeRequestModel reservationTripeRequestModel) async {
    return await addTripeRepositoryInterface
        .reservationTripe(reservationTripeRequestModel);
  }

  @override
  Future<dynamic> cancelAndAcceptTripe(
      CancelAmdStartTripeRequestModel cancelAmdStartTripeRequestModel) async {
    return await addTripeRepositoryInterface
        .cancelAndAcceptTripe(cancelAmdStartTripeRequestModel);
  }
}
