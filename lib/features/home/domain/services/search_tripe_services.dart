
import 'package:hoooob_app/features/home/domain/models/search_tripe_request_model.dart';
import 'package:hoooob_app/features/home/domain/repositories/search_tripe_repository_interface.dart';
import 'package:hoooob_app/features/home/domain/services/search_tripe_services_interface.dart';

class SearchTripeService implements SearchTripeServiceInterface {
  final SearchTripeRepositoryInterface searchTripeRepositoryInterface;

  SearchTripeService({required this.searchTripeRepositoryInterface});

  @override
  Future<dynamic> searchTripe(SearchTripeRequestModel searchTripeRequestModel,String? category) async {
    return await searchTripeRepositoryInterface.searchTripe(searchTripeRequestModel,category);
  }
}
