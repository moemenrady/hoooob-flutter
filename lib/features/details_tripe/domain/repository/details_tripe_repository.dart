import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hoooob_app/data/api_client.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/cancel_and_start_tripe_request.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/reservation_tripe_request_model.dart';
import 'package:hoooob_app/features/details_tripe/domain/repository/details_tripe_repository_interface.dart';
import 'package:hoooob_app/util/app_constants.dart';

class DetailsTripeRepository implements DetailsTripeRepositoryInterface {
  final ApiClient apiClient;

  DetailsTripeRepository({required this.apiClient});

  @override
  Future<Response> reservationTripe(
      ReservationTripeRequestModel reservationTripeRequestModel) async {
    return await apiClient.postData(
        AppConstants.joinTripe, reservationTripeRequestModel.toJson());
  }

  @override
  Future cancelAndAcceptTripe(CancelAmdStartTripeRequestModel cancelAmdStartTripeRequestModel) async{
    return await apiClient.postData(
        AppConstants.cancelAndAcceptTripe, cancelAmdStartTripeRequestModel.toJson());

  }
}
