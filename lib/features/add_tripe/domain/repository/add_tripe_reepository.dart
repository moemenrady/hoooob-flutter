import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hoooob_app/data/api_client.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/add_tripe/domain/repository/add_tripe_repository_interface.dart';
import 'package:hoooob_app/util/app_constants.dart';

class AddTripeRepository implements AddTripeRepositoryInterface {
  final ApiClient apiClient;

  AddTripeRepository({required this.apiClient});

  @override
  Future<Response> createTripe(AddTripeRequestModel addTripeFormData) async {
    return await apiClient.postData(
        AppConstants.addDriverTripe, addTripeFormData.toJson());
  }

  @override
  Future<Response> getAllVehicles() async{
    return await apiClient.getData(AppConstants.allVehicles);
  }
}
