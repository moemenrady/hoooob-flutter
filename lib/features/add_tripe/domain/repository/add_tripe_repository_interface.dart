import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/home/domain/repositories/add_car_repository_interface.dart';

abstract class AddTripeRepositoryInterface  {
  Future<dynamic> createTripe(AddTripeRequestModel addTripeFormData );
  Future<dynamic> getAllVehicles( );
}