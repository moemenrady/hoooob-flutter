import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/data/api_checker.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';
import 'package:hoooob_app/features/trip/domain/models/passengers_tripes_response_model.dart';
import 'package:hoooob_app/features/trip/domain/models/trip_cancelation_cause_list_model.dart';
import 'package:hoooob_app/features/trip/domain/models/trip_model.dart';
import 'package:hoooob_app/features/trip/domain/services/service_interface.dart';

class TripeController extends GetxController implements GetxService {
  final TripServiceInterface tripServiceInterface;

  TripeController({required this.tripServiceInterface});

  final List<String> _filterList = [
    'all_time',
    'today',
    'previous_day',
    'custom_date'
  ];
  final List<String> _statusList = [
    'all',
    'ongoing',
    'cancelled',
    'completed',
    'returned'
  ];
  int statusIndex = 0;
  int filterIndex = 0;
  bool _showCustomDate = false;
  String _filterStartDate = '';
  String _filterEndDate = '';
  TripModel? tripModel;
  List<DriverTrip> driverAllTripeList = [];
  List<TripePassengerData> passengersAllTripeList = [];
  ValueNotifier<bool> driverAllTripeListLoading = ValueNotifier(false);
  ValueNotifier<bool> passengersAllTripeListLoading = ValueNotifier(false);

  // Trip management states
  Set<int> _tripsBeingStarted = {};
  Set<int> _tripsBeingEnded = {};
  String _currentTripStatusFilter = 'all'; // all, pending, ongoing, completed

  List<String> get filterList => _filterList;

  bool get showCustomDate => _showCustomDate;

  String get filterStartDate => _filterStartDate;

  String get filterEndDate => _filterEndDate;

  void initData() {
    filterIndex = 0;
    statusIndex = 0;
    _showCustomDate = false;
    _filterStartDate = '';
    _filterEndDate = '';
  }

  void setStatusIndex(int index) {
    statusIndex = index;
    getTripList(1, reload: true);
    update();
  }

  void setFilterTypeName(int index) {
    filterIndex = index;
    getTripList(1, reload: true);
    update();
  }

  Future<void> getTripList(int offset, {bool reload = false}) async {
    if (reload) {
      tripModel = null;
      update();
    }
    Response response = await tripServiceInterface.getTripList(
        'ride_request',
        offset,
        _filterStartDate,
        _filterEndDate,
        _filterList[filterIndex],
        _statusList[statusIndex]);
    if (response.statusCode == 200 && response.body['date'] != []) {
      if (offset == 1) {
        tripModel = TripModel.fromJson(response.body);
      } else {
        tripModel?.data!.addAll(TripModel.fromJson(response.body).data!);
        tripModel?.offset = TripModel.fromJson(response.body).offset;
        tripModel?.totalSize = TripModel.fromJson(response.body).totalSize;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateShowCustomDateState(bool state) {
    _showCustomDate = state;
    update();
  }

  void setFilterDateRangeValue({String? start, String? end}) {
    filterIndex = _filterList.length - 1;
    _filterStartDate = start ?? '';
    _filterEndDate = end ?? '';
    getTripList(1);
    update();
  }

  TripCancellationCauseList? rideCancellationReasonList;
  TripCancellationCauseList? parcelCancellationReasonList;
  TextEditingController othersCancellationController = TextEditingController();

  int rideCancellationCauseCurrentIndex = 0;
  int parcelCancellationCauseCurrentIndex = 0;

  void getRideCancellationReasonList() async {
    Response response =
        await tripServiceInterface.getRideCancellationReasonList();

    if (response.statusCode == 200) {
      rideCancellationReasonList =
          TripCancellationCauseList.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void getParcelCancellationReasonList() async {
    Response response =
        await tripServiceInterface.getParcelCancellationReasonList();

    if (response.statusCode == 200) {
      parcelCancellationReasonList =
          TripCancellationCauseList.fromJson(response.body);
      parcelCancellationReasonList?.data?.ongoingRide?.add('other'.tr);
      parcelCancellationReasonList?.data?.acceptedRide?.add('other'.tr);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void setRideCancellationCurrentIndex(int index) {
    rideCancellationCauseCurrentIndex = index;
  }

  void setParcelCancellationCurrentIndex(int index) {
    parcelCancellationCauseCurrentIndex = index;
  }

  void driverGetAllTripe() async {
    driverAllTripeListLoading.value = true;
    Response response = await tripServiceInterface.driverGetAllTripe();
    if (response.statusCode == 200) {
      var data = DriverTripsResponseModel.fromJson(response.body);
      driverAllTripeList = data.data;
      print('datadatadatadatadatadatadatadatadata');
      driverAllTripeListLoading.value = false;
    } else {
      driverAllTripeListLoading.value = false;
    }
  }

  void passengersGetAllTripe() async {
    passengersAllTripeListLoading.value = true;
    Response response = await tripServiceInterface.passengersGetAllTripe();
    if (response.statusCode == 200) {
      var data = PassengerAllTripeResponseModel.fromJson(response.body);
      passengersAllTripeList = data.data;
      print('datadatadatadatadatadatadatadatadata');
      passengersAllTripeListLoading.value = false;
    } else {
      passengersAllTripeListLoading.value = false;
    }
  }

  // Trip Management Methods
  String get currentTripStatusFilter => _currentTripStatusFilter;

  List<DriverTrip> get filteredDriverTrips {
    if (_currentTripStatusFilter == 'all') {
      return driverAllTripeList;
    }
    return driverAllTripeList.where((trip) {
      // Assuming trip status is determined by some field
      // You may need to adjust this based on your actual data structure
      return getTripStatus(trip) == _currentTripStatusFilter;
    }).toList();
  }

  String getTripStatus(DriverTrip trip) {
    // Based on API response structure:
    // - is_start: false/0 + end_time: empty = pending
    // - is_start: false/0 + end_time: has value = completed
    // - is_start: true/1 + end_time: empty = ongoing
    // - is_start: true/1 + end_time: has value = completed

    // First check if trip has end time (completed regardless of isStart)
    if (trip.endTime != null && trip.endTime!.isNotEmpty) {
      return 'completed';
    }

    // Then check isStart status
    if (trip.isStart == false || trip.isStart == 0) {
      return 'pending';
    } else if (trip.isStart == true || trip.isStart == 1) {
      return 'ongoing';
    }

    // Default fallback
    return 'pending';
  }

  void setTripStatusFilter(String status) {
    _currentTripStatusFilter = status;
    update();
  }

  bool isTripBeingStarted(int tripId) {
    return _tripsBeingStarted.contains(tripId);
  }

  bool isTripBeingEnded(int tripId) {
    return _tripsBeingEnded.contains(tripId);
  }

  Future<void> startTrip(int tripId) async {
    _tripsBeingStarted.add(tripId);
    update();

    try {
      // Call the API to start the trip
      Response response = await tripServiceInterface.startTrip(tripId);
      if (response.statusCode == 200) {
        // Trip started successfully
        Get.showSnackbar(GetSnackBar(
          title: 'Success',
          message: 'Trip started successfully',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
        // Refresh the trip list
        driverGetAllTripe();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: 'Failed to start trip: $e',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    } finally {
      _tripsBeingStarted.remove(tripId);
      update();
    }
  }

  Future<void> endTrip(int tripId) async {
    _tripsBeingEnded.add(tripId);
    update();

    try {
      // Call the API to end the trip
      Response response = await tripServiceInterface.endTrip(tripId);
      if (response.statusCode == 200) {
        // Trip ended successfully
        Get.showSnackbar(GetSnackBar(
          title: 'Success',
          message: 'Trip ended successfully',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
        // Refresh the trip list
        driverGetAllTripe();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: 'Failed to end trip: $e',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    } finally {
      _tripsBeingEnded.remove(tripId);
      update();
    }
  }

  Color getTripStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'ongoing':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getTripStatusDisplayText(String status) {
    switch (status) {
      case 'pending':
        return 'pending'.tr;
      case 'ongoing':
        return 'ongoing'.tr;
      case 'completed':
        return 'completed'.tr;
      case 'cancelled':
        return 'cancelled'.tr;
      default:
        return 'unknown'.tr;
    }
  }
}
