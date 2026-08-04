import 'package:get/get.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_request_model.dart';

abstract class SearchTripeServiceInterface {
  Future<dynamic> searchTripe(SearchTripeRequestModel searchTripeRequestModel,String? category);
}
