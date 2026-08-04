import 'package:get/get.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';

abstract class AddTripeServiceInterface {
  Future<dynamic> createTripe( AddTripeRequestModel addTripeFormData);
  Future<dynamic> getAllVehicles();
}
