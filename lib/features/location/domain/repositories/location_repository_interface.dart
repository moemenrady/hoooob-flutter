import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/location/domain/models/all_user_search_tripe_model.dart';
import 'package:hoooob_app/features/location/domain/models/user_search_tripe_model.dart';
import 'package:hoooob_app/interface/repository_interface.dart';

abstract class LocationRepositoryInterface implements RepositoryInterface{
  Future<dynamic> getZone(String lat, String lng);
  Future<dynamic> getAddressFromGeocode(LatLng? latLng);
  Future<dynamic> searchLocation(String text);
  Future<dynamic> getPlaceDetails(String placeID);
  Future<bool> saveUserAddress(Address? address);
  String? getUserAddress();
  Future<dynamic> searchUserTripe(UserSearchTripeModel userSearchTripe);


}