import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/location/domain/models/all_user_search_tripe_model.dart';
import 'package:hoooob_app/features/location/domain/models/user_search_tripe_model.dart';
import 'package:hoooob_app/features/location/domain/repositories/location_repository_interface.dart';
import 'package:hoooob_app/features/location/domain/services/location_service_interface.dart';

class LocationService implements LocationServiceInterface {
  LocationRepositoryInterface locationRepositoryInterface;

  LocationService({required this.locationRepositoryInterface});

  @override
  Future getAddressFromGeocode(LatLng? latLng) async {
    return await locationRepositoryInterface.getAddressFromGeocode(latLng);
  }

  @override
  Future getPlaceDetails(String placeID) async {
    return await locationRepositoryInterface.getPlaceDetails(placeID);
  }

  @override
  Future searchUserTripe(UserSearchTripeModel userSearchTripe) async {
    return await locationRepositoryInterface.searchUserTripe(userSearchTripe);
  }

  @override
  String? getUserAddress() {
    return locationRepositoryInterface.getUserAddress();
  }

  @override
  Future getZone(String lat, String lng) async {
    return await locationRepositoryInterface.getZone(lat, lng);
  }

  @override
  Future<bool> saveUserAddress(Address? address) async {
    return await locationRepositoryInterface.saveUserAddress(address);
  }

  @override
  Future searchLocation(String text) async {
    return await locationRepositoryInterface.searchLocation(text);
  }


}
