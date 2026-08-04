import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/add_tripe/domain/repository/add_tripe_repository_interface.dart';
import 'package:hoooob_app/features/add_tripe/domain/services/add_tripe_services_interface.dart';

class AddTripeService implements AddTripeServiceInterface {
  final AddTripeRepositoryInterface addTripeRepositoryInterface;

  AddTripeService({required this.addTripeRepositoryInterface});

  @override
  Future<dynamic> createTripe(AddTripeRequestModel addTripeFormData) async {
    return await addTripeRepositoryInterface.createTripe(addTripeFormData);
  }

  @override
  Future getAllVehicles() async {
    return await addTripeRepositoryInterface.getAllVehicles();
  }
}
