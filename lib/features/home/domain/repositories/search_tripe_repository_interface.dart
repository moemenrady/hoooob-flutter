import 'package:hoooob_app/features/home/domain/models/search_tripe_request_model.dart';

abstract class SearchTripeRepositoryInterface  {
  Future<dynamic> searchTripe(SearchTripeRequestModel searchTripeRequestModel ,String? category);
}