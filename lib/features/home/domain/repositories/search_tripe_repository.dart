import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hoooob_app/data/api_client.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_request_model.dart';
import 'package:hoooob_app/features/home/domain/repositories/search_tripe_repository_interface.dart';
import 'package:hoooob_app/util/app_constants.dart';

class SearchTripeRepository implements SearchTripeRepositoryInterface {
  final ApiClient apiClient;

  SearchTripeRepository({required this.apiClient});

  @override
  Future<Response> searchTripe(SearchTripeRequestModel searchTripeRequestModel,String? category) async {
    return await apiClient.postData('${AppConstants.allSearchTripe}${category ?? ''}',searchTripeRequestModel.toJson());
  }
}
