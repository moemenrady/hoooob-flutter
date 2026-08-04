import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hoooob_app/common_widgets/custom_snackbar.dart';
import 'package:hoooob_app/common_widgets/image_title_subtitle.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/add_tripe_request_model.dart';
import 'package:hoooob_app/features/add_tripe/domain/models/all_vechile_response_model.dart';
import 'package:hoooob_app/features/add_tripe/domain/services/add_tripe_services_interface.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/home/controllers/add_car_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddTripeController extends GetxController implements GetxService {
  final AddTripeServiceInterface addTripeServiceInterface;

  AddTripeController({required this.addTripeServiceInterface});

  ValueNotifier<bool> isFromToDetails = ValueNotifier(true);
  ValueNotifier<bool> isLoadingAddTripe = ValueNotifier(false);
  TextEditingController priceController = TextEditingController();
  String errorMessage = '';
  List<AllVehicleData> allVehiclesList = [];
  List<String> vehicleNames = [];

// map of drop down
  Map<String, List> detailsDropDown = {
    'available_seats': ['1', '2', '3', '4'],
    'air_conditioner': ['yes', 'no'],
    'music': ['yes', 'no'],
    'smoking': ['yes', 'no'],
    'passenger_gender': ['male', 'female'],
    'age': [
      '18 : 24',
      '24 : 30',
      '30 : 40',
      '40 : 45',
      '45 : 50',
      '50 : 60',
      '60 : 100'
    ],
    'show_Movie_on_the_screen': ['yes', 'no'],
    'front_seat': ['yes', 'no'],
    'bags': ['yes', 'no'],
    'choose_from_you_car': [
      {'id': 'A', 'name': 'Toyota'},
      {'id': 'B', 'name': 'Hyundai'},
    ],
  };

  void updateDetailsDropDown() {
    // detailsDropDown['choose_from_you_car'] =
    //     allVehiclesList.map((e) => e.vehicleBrand ?? 'Unknown').toList();
  }

  void selectIndexDropDownMenu(
      AddTripeController controller, String key, String value) {
    switch (key) {
      case 'available_seats':
        controller.availableSeats = value;
        break;
      case 'air_conditioner':
        controller.airConditioner = value;
        break;
      case 'music':
        controller.music = value;
        break;
      case 'smoking':
        controller.smoking = value;
        break;
      case 'passenger_gender':
        controller.gender = value;
        break;
      case 'age':
        controller.maxAge = value;
        maxAge = value.split(':')[1];
        minAge = value.split(':')[0];

        break;
      case 'show_Movie_on_the_screen':
        controller.movies = value;
        break;
      case 'bags':
        controller.bags = value;
        break;
      case 'front_seat':
        controller.frontSeat = value;
        break;
      case 'choose_from_you_car':
        controller.vehicleId = value;
        print('====> Selected Vehicle ID: $value');
        break;
    }
  }

// this method convert value yes or no to 1 or 0
  String convertYesNoToBinary(String? value) {
    final normalized = value?.toLowerCase().trim();
    if (normalized == 'no' || normalized == 'لا') return '0';
    if (normalized == 'yes' || normalized == 'نعم') return '1';
    // fallback if not valid
    throw FormatException('Invalid Yes/No value: $value');
  }

  String? availableSeats;
  String? airConditioner;
  String? music;
  String? smoking;
  String? gender;
  String? maxAge;
  String? minAge;
  String? movies;
  String? frontSeat;
  String? bags;
  String? vehicleId;
  DateTime? startTime;
  double? startLat;
  double? startLng;
  double? endLat;
  double? endLng;
  List<Map<String, dynamic>>? restStops;

  // List<AllVehicleData>? allVehiclesList;
  void addTripe() async {
    isLoadingAddTripe.value = true;
    update();

    try {
      // Generate encoded polyline before sending request
      await generateEncodedPolyline();

      final requestModel = addTripeRequestModel();
      print('====> Sending request with data: ${requestModel.toJson()}');

      Response response =
          await addTripeServiceInterface.createTripe(requestModel);
      if (response.statusCode == 200) {
        print('===========================>success11111');
        isLoadingAddTripe.value = false;
        update();
        Get.to(() => ImageTitleSubTitle(
              title: 'congrats'.tr,
              subTitle: 'create_tripe_success'.tr,
              onPressed: () {
                isFromToDetails.value = true;
                update();
                Get.back();
                clearDataAfterAddTripe();
              },
            ));
      } else {
        isLoadingAddTripe.value = false;

        final body = response.body;

        if (body is Map &&
            body['errors'] != null &&
            body['errors'] is List &&
            body['errors'].isNotEmpty) {
          errorMessage =
              body['errors']['message'] ?? body['message'] ?? errorMessage;
        } else if (body['message'] != null) {
          errorMessage = body['message'];
        }

        print('errorMessage => $errorMessage');
        customSnackBar(errorMessage, isError: true);
      }
    } catch (failure) {
      isLoadingAddTripe.value = false;
      update();
    }
    Get.find<LocationController>().pickupLocationController.clear();
    // Get.find<LocationController>()..clear();
  }

  void customSnackBar(String? message, {bool isError = true}) {
    if (message != null && message.isNotEmpty) {
      Get.rawSnackbar(
        backgroundColor: isError ? Colors.red : Colors.green,
        message: message,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        borderRadius: 10,
        isDismissible: true,
      );
    }
  }

//=======================================================>
  void clearDataAfterAddTripe() {
    priceController.clear();
    Get.find<LocationController>().restStopsList.clear();
    Get.find<LocationController>().restStopController.clear();
    Get.find<LocationController>().dateController.clear();
    Get.find<LocationController>().addPassengersController.clear();
    Get.find<LocationController>().addPassengersController.clear();
  }

  //=======================================================>
  AddTripeRequestModel addTripeRequestModel() {
    // Get vehicle ID from profile controller (the working way)
    final profileController = Get.find<AddCarController>();
    final profileVehicleId = profileController.profileInfo?.vehicle?.id;
    final selectedVehicleId =
        profileVehicleId ?? '0ce1f99b-d55c-4b49-95a6-d2208b54f4b0';

    print('====> Profile Info: ${profileController.profileInfo?.id}');
    print(
        '====> Profile Vehicle: ${profileController.profileInfo?.vehicle?.licencePlateNumber}');
    print('====> Profile Vehicle ID: $profileVehicleId');
    print('====> Using Vehicle ID: $selectedVehicleId');
    print('====> Encoded Polyline: $_encodedPolyline');

    return AddTripeRequestModel(
        startLat: startLat!,
        endLat: endLat!,
        startLng: startLng!,
        endLng: endLng!,
        startTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime!),
        vehicleId:
            selectedVehicleId, // Use profile vehicle ID (the working way)
        seatsAvailable: int.parse(availableSeats!),
        isAc: int.parse(convertYesNoToBinary(airConditioner)),
        isSmokingAllowed: int.parse(convertYesNoToBinary(smoking)),
        hasMusic: int.parse(convertYesNoToBinary(music)),
        isMovies: int.parse(convertYesNoToBinary(movies)),
        allowLuggage: int.parse(convertYesNoToBinary(bags)),
        gender: gender!,
        allowedAgeMax: int.parse(maxAge!),
        allowedAgeMin: int.parse(minAge!),
        price: int.parse(priceController.text),
        restStops: [],
        encodedPolyline: _encodedPolyline);
  }

  //===> this method check if the value is yes or no or null
  bool isValidYesNo(String? v) {
    if (v == null) return false;
    return v == 'Yes' || v == 'No' || v == 'نعم' || v == 'لا';
  }

//========================================================>

  //===> this method used with button create tripe
  void actionThenTapButton(AddTripeController addTripeController) {
    if (addTripeController.priceController.text.isEmpty ||
        addTripeController.availableSeats!.isEmpty ||
        !isValidYesNo(addTripeController.airConditioner) ||
        !isValidYesNo(addTripeController.music) ||
        !isValidYesNo(addTripeController.smoking) ||
        addTripeController.gender!.isEmpty ||
        addTripeController.minAge!.isEmpty ||
        addTripeController.maxAge!.isEmpty ||
        !isValidYesNo(addTripeController.movies) ||
        !isValidYesNo(addTripeController.frontSeat) ||
        addTripeController.bags!.isEmpty) {
      customSnackBar('please_enter_all_data'.tr, isError: true);
    } else {
      // Use the original addTripe flow but with encoded polyline
      addTripeController.addTripe();
    }
  }

//========================================================>

  void getAllVehicles() async {
    Response response = await addTripeServiceInterface.getAllVehicles();
    if (response.statusCode == 200) {
      var vehicles = AllVehiclesResponseModel.fromJson(response.body);
      allVehiclesList = vehicles.allVehicle!;
      vehicleNames.addAll(vehicles.allVehicle!.map((e) => e.vehicleBrand!));
      updateDetailsDropDown();
    }
  }

  // Register Route functionality
  String _encodedPolyline = '';
  String get encodedPolyline => _encodedPolyline;

  // Method to register route with enhanced functionality
  Future<void> registerRoute() async {
    if (!_validateFormForRegisterRoute()) {
      return;
    }

    // Show data preview dialog first
    await _showDataPreviewDialog();
  }

  bool _validateFormForRegisterRoute() {
    // Validate coordinates
    if (startLat == null || startLng == null) {
      customSnackBar('please_select_starting_point'.tr, isError: true);
      return false;
    }

    if (endLat == null || endLng == null) {
      customSnackBar('please_select_destination'.tr, isError: true);
      return false;
    }

    // Validate start time
    if (startTime == null) {
      customSnackBar('please_select_departure_time'.tr, isError: true);
      return false;
    }

    // Validate price
    if (priceController.text.isEmpty) {
      customSnackBar('please_enter_price_per_seat'.tr, isError: true);
      return false;
    }

    try {
      double price = double.parse(priceController.text);
      if (price <= 0) {
        customSnackBar('price_must_be_greater_than_zero'.tr, isError: true);
        return false;
      }
    } catch (e) {
      customSnackBar('please_enter_valid_price'.tr, isError: true);
      return false;
    }

    // Validate seats
    if (availableSeats == null || availableSeats!.isEmpty) {
      customSnackBar('please_enter_available_seats'.tr, isError: true);
      return false;
    }

    try {
      int seats = int.parse(availableSeats!);
      if (seats <= 0 || seats > 50) {
        customSnackBar('seats_must_be_between_1_and_50'.tr, isError: true);
        return false;
      }
    } catch (e) {
      customSnackBar('please_enter_valid_number_of_seats'.tr, isError: true);
      return false;
    }

    // Validate age limits if provided
    if (minAge != null && maxAge != null) {
      try {
        int minAgeInt = int.parse(minAge!);
        int maxAgeInt = int.parse(maxAge!);

        if (minAgeInt < 13 || minAgeInt > 100) {
          customSnackBar('minimum_age_must_be_between_13_and_100'.tr,
              isError: true);
          return false;
        }

        if (maxAgeInt < 13 || maxAgeInt > 100) {
          customSnackBar('maximum_age_must_be_between_13_and_100'.tr,
              isError: true);
          return false;
        }

        if (minAgeInt > maxAgeInt) {
          customSnackBar('minimum_age_cannot_be_greater_than_maximum_age'.tr,
              isError: true);
          return false;
        }
      } catch (e) {
        customSnackBar('please_enter_valid_age_limits'.tr, isError: true);
        return false;
      }
    }

    return true;
  }

  // Method to show data preview dialog
  Future<void> _showDataPreviewDialog() async {
    final data = getCurrentFormDataForRegisterRoute();

    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 600, maxWidth: 400),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.preview,
                    color: Theme.of(Get.context!).primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Route Data Preview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(height: 20),

              // Data content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDataSection('🎯 Route Information', [
                        'Start: $startLat, $startLng',
                        'End: $endLat, $endLng',
                        'Departure: $startTime',
                      ]),
                      _buildDataSection('🚗 Vehicle & Pricing', [
                        'Price per seat: ${priceController.text} EGP',
                        'Available seats: $availableSeats',
                        'Vehicle ID: $vehicleId',
                      ]),
                      _buildDataSection('👥 Passenger Preferences', [
                        'Min age: $minAge',
                        'Max age: $maxAge',
                        'Allowed gender: $gender',
                      ]),
                      _buildDataSection('✨ Vehicle Features', [
                        'AC: ${airConditioner == 'yes' ? 'Yes' : 'No'}',
                        'Smoking: ${smoking == 'yes' ? 'Yes' : 'No'}',
                        'Music: ${music == 'yes' ? 'Yes' : 'No'}',
                        'Movies: ${movies == 'yes' ? 'Yes' : 'No'}',
                        'Luggage: ${bags == 'yes' ? 'Yes' : 'No'}',
                      ]),
                      if (restStops != null && restStops!.isNotEmpty)
                        _buildDataSection(
                            '🛑 Rest Stops',
                            restStops!
                                .map((stop) =>
                                    '${stop['name']}: ${stop['lat']}, ${stop['lng']}')
                                .toList()),
                      _buildDataSection('🗺️ Route Polyline', [
                        'Status: ${_encodedPolyline.isNotEmpty ? 'Generated' : 'Not generated'}',
                        'Length: ${_encodedPolyline.length} characters',
                        if (_encodedPolyline.isNotEmpty)
                          'Preview: ${_encodedPolyline.length > 30 ? '${_encodedPolyline.substring(0, 30)}...' : _encodedPolyline}',
                      ]),
                    ],
                  ),
                ),
              ),

              const Divider(height: 20),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(Get.context!),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(Get.context!);
                        _proceedWithRegisterRoute();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(Get.context!).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Register Route'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildDataSection(String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Method to actually proceed with registration
  Future<void> _proceedWithRegisterRoute() async {
    // Generate encoded polyline before sending request
    await generateEncodedPolyline();

    isLoadingAddTripe.value = true;
    update();

    try {
      // Prepare the request model with all collected data
      final requestModel = AddTripeRequestModel(
        startLat: startLat!,
        startLng: startLng!,
        endLat: endLat!,
        endLng: endLng!,
        startTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime!),
        price: int.parse(priceController.text),
        vehicleId: vehicleId ?? '0ce1f99b-d55c-4b49-95a6-d2208b54f4b0',
        seatsAvailable: int.parse(availableSeats!),
        allowedAgeMin: minAge != null ? int.parse(minAge!) : 0,
        allowedAgeMax: maxAge != null ? int.parse(maxAge!) : 100,
        gender: gender ?? 'both',
        isAc: int.parse(convertYesNoToBinary(airConditioner)),
        isSmokingAllowed: int.parse(convertYesNoToBinary(smoking)),
        hasMusic: int.parse(convertYesNoToBinary(music)),
        isMovies: int.parse(convertYesNoToBinary(movies)),
        allowLuggage: int.parse(convertYesNoToBinary(bags)),
        restStops: restStops ?? [],
        encodedPolyline: _encodedPolyline,
      );

      // Call the API service
      Response response =
          await addTripeServiceInterface.createTripe(requestModel);

      isLoadingAddTripe.value = false;
      update();

      if (response.statusCode == 200) {
        customSnackBar('route_registered_successfully'.tr, isError: false);

        // Navigate to success screen
        Get.to(() => ImageTitleSubTitle(
              title: 'congrats'.tr,
              subTitle: 'route_registered_successfully'.tr,
              onPressed: () {
                isFromToDetails.value = true;
                update();
                Get.back();
                clearDataAfterAddTripe();
              },
            ));
      } else {
        final body = response.body;
        String errorMessage = 'failed_to_register_route'.tr;

        if (body is Map && body['message'] != null) {
          errorMessage = body['message'];
        }

        customSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      isLoadingAddTripe.value = false;
      update();

      String errorMessage = 'network_error_please_try_again'.tr;
      if (e.toString().contains('timeout')) {
        errorMessage = 'request_timeout_please_try_again'.tr;
      } else if (e.toString().contains('socket') ||
          e.toString().contains('network')) {
        errorMessage = 'check_your_internet_and_try_again'.tr;
      }

      customSnackBar(errorMessage, isError: true);
    }
  }

  // Method to get current form data for debugging
  Map<String, dynamic> getCurrentFormDataForRegisterRoute() {
    return {
      'startCoordinates': {
        'lat': startLat,
        'lng': startLng,
      },
      'endCoordinates': {
        'lat': endLat,
        'lng': endLng,
      },
      'startTime': startTime,
      'price': priceController.text,
      'vehicleId': vehicleId,
      'seats': availableSeats,
      'ageRestrictions': {
        'minAge': minAge,
        'maxAge': maxAge,
      },
      'allowedGender': gender,
      'features': {
        'isAc': airConditioner == 'yes',
        'isSmokingAllowed': smoking == 'yes',
        'hasMusic': music == 'yes',
        'hasMovies': movies == 'yes',
        'allowLuggage': bags == 'yes',
      },
      'restStops': restStops ?? [],
      'encodedPolyline': _encodedPolyline,
    };
  }

  // Method to generate encoded polyline from coordinates
  Future<void> generateEncodedPolyline() async {
    try {
      // Validate that we have start and end coordinates
      if (startLat == null ||
          startLng == null ||
          endLat == null ||
          endLng == null) {
        print('====> Cannot generate polyline: Missing coordinates');
        _encodedPolyline = '';
        return;
      }

      // Try to get detailed route from Google Maps API first
      String? detailedPolyline = await _getDetailedRouteFromGoogleMaps(
          startLat!, startLng!, endLat!, endLng!);

      if (detailedPolyline != null && detailedPolyline.isNotEmpty) {
        // Use Google Maps detailed route
        _encodedPolyline = detailedPolyline;
        print('====> Using Google Maps detailed polyline');
      } else {
        // Fallback to simple polyline with rest stops
        List<Map<String, double>> coordinates = [
          {'lat': startLat!, 'lng': startLng!}, // Start point
        ];

        // Add rest stops if any
        if (restStops != null) {
          for (final restStop in restStops!) {
            coordinates.add({
              'lat': restStop['lat'] as double,
              'lng': restStop['lng'] as double,
            });
          }
        }

        // Add end point
        coordinates.add({'lat': endLat!, 'lng': endLng!});

        // Generate simple encoded polyline
        _encodedPolyline = _encodePolyline(coordinates);
        print('====> Using simple polyline with rest stops');
      }

      print('====> Generated encoded polyline: $_encodedPolyline');
      print('====> Polyline length: ${_encodedPolyline.length} characters');

      // Update UI to reflect the new polyline
      update();
    } catch (e) {
      print('====> Error generating encoded polyline: $e');
      _encodedPolyline = '';
      update();
    }
  }

  // Get detailed route from Google Maps API
  Future<String?> _getDetailedRouteFromGoogleMaps(
      double startLat, double startLng, double endLat, double endLng) async {
    try {
      // Google Maps API key (you should use your own key)
      const String apiKey = 'AIzaSyBEBg6ItImxrxhsGbv7G9KNyvy1gr2MGwo';

      // Build waypoints string for rest stops
      String waypoints = '';
      if (restStops != null && restStops!.isNotEmpty) {
        waypoints =
            restStops!.map((stop) => '${stop['lat']},${stop['lng']}').join('|');
      }

      // Build URL
      String url = 'https://maps.googleapis.com/maps/api/directions/json?'
          'origin=$startLat,$startLng&'
          'destination=$endLat,$endLng&'
          '${waypoints.isNotEmpty ? 'waypoints=$waypoints&' : ''}'
          'key=$apiKey&'
          'mode=driving';

      print('====> Google Maps API URL: $url');

      // Make HTTP request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final polylineString = route['overview_polyline']['points'];

          print('====> Google Maps polyline received: $polylineString');
          return polylineString;
        } else {
          print('====> Google Maps API error: ${data['status']}');
          return null;
        }
      } else {
        print('====> Google Maps API HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('====> Error calling Google Maps API: $e');
      return null;
    }
  }

  // Polyline encoding algorithm (Google's polyline algorithm)
  String _encodePolyline(List<Map<String, double>> coordinates) {
    if (coordinates.isEmpty) return '';

    String encoded = '';
    int prevLat = 0;
    int prevLng = 0;

    for (final coord in coordinates) {
      int lat = (coord['lat']! * 1e5).round();
      int lng = (coord['lng']! * 1e5).round();

      int dLat = lat - prevLat;
      int dLng = lng - prevLng;

      encoded += _encodeSignedNumber(dLat);
      encoded += _encodeSignedNumber(dLng);

      prevLat = lat;
      prevLng = lng;
    }

    return encoded;
  }

  // Encode a signed number for polyline
  String _encodeSignedNumber(int num) {
    int sgnNum = num << 1;
    if (num < 0) {
      sgnNum = ~sgnNum;
    }
    return _encodeNumber(sgnNum);
  }

  // Encode a number for polyline
  String _encodeNumber(int num) {
    String encoded = '';
    while (num >= 0x20) {
      encoded += String.fromCharCode(((num & 0x1F) | 0x20) + 63);
      num >>= 5;
    }
    encoded += String.fromCharCode(num + 63);
    return encoded;
  }
}
