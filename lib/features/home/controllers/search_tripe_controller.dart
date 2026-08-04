import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hoooob_app/features/home/domain/models/add_car_category.dart';
import 'package:hoooob_app/features/home/domain/models/recent_search_model.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_request_model.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/features/home/domain/services/add_car_services_interface.dart';
import 'package:hoooob_app/features/home/domain/services/search_tripe_services_interface.dart';
import 'package:hoooob_app/features/search_trips/screens/search_trips_screen.dart';
import 'package:hoooob_app/helper/recent_search_helper.dart';

class SearchTripeController extends GetxController implements GetxService {
  final SearchTripeServiceInterface searchTripeServiceInterface;
  final AddCarServiceInterface addCarServiceInterface;

  SearchTripeController(
      {required this.searchTripeServiceInterface,
      required this.addCarServiceInterface});

  List<SearchTripeAll> searchTripeList = [];
  ValueNotifier<bool> isLoadingSearchTripe = ValueNotifier(false);
  double? startLat;
  double? startLng;
  double? endLat;
  double? endLng;
  int? availableSeats;
  String? startTime;
  String? startAddress;
  String? endAddress;
  List<String> select = ["all".tr];
  List<RecentSearchModel> recentSearches = [];

  void setLocationData({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
    required String startAddress,
    required String endAddress,
    required int availableSeats,
    required String startTime,
  }) {
    this.startLat = startLat;
    this.startLng = startLng;
    this.endLat = endLat;
    this.endLng = endLng;
    this.startAddress = startAddress;
    this.endAddress = endAddress;
    this.availableSeats = availableSeats;
    this.startTime = startTime;
    update();
  }

  /// Load recent searches from SharedPreferences
  Future<void> loadRecentSearches() async {
    recentSearches = await RecentSearchHelper.getRecentSearches();
    update();
  }

  /// Save current search to recent searches
  Future<void> saveCurrentSearch() async {
    if (startAddress != null && endAddress != null && startTime != null) {
      final recentSearch = RecentSearchModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fromLocation: startAddress!,
        toLocation: endAddress!,
        date: startTime!,
        passengers: availableSeats ?? 1,
        startLat: startLat,
        startLng: startLng,
        endLat: endLat,
        endLng: endLng,
        createdAt: DateTime.now(),
      );

      await RecentSearchHelper.saveRecentSearch(recentSearch);
      await loadRecentSearches(); // Refresh the list
    }
  }

  /// Use a recent search (set current search data from recent search)
  void useRecentSearch(RecentSearchModel recentSearch) {
    setLocationData(
      startLat: recentSearch.startLat ?? 0.0,
      startLng: recentSearch.startLng ?? 0.0,
      endLat: recentSearch.endLat ?? 0.0,
      endLng: recentSearch.endLng ?? 0.0,
      startAddress: recentSearch.fromLocation,
      endAddress: recentSearch.toLocation,
      availableSeats: recentSearch.passengers,
      startTime: recentSearch.date,
    );
  }

  /// Clear all recent searches
  Future<void> clearRecentSearches() async {
    await RecentSearchHelper.clearRecentSearches();
    await loadRecentSearches();
  }

  void getAllSearchTripe(String? category) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoadingSearchTripe.value = true;
    });
    if (categoryList.isEmpty) {
      await getCategoryList(1);
    }
    Response response = await searchTripeServiceInterface.searchTripe(
        SearchTripeRequestModel(
          pickupLat: startLat!,
          pickupLng: startLng!,
          dropOffLat: endLat!,
          dropOffLng: endLng!,
          seatsRequired: availableSeats!,
          day: startTime!,
        ),
        category ?? '');

    if (response.statusCode == 200) {
      print('booooooooooody${response.body}');
      var data = SearchTripeResponseModel.fromJson(response.body);
      print('responseresponseresponseresponse${data.data}');
      searchTripeList.clear();
      searchTripeList = data.data!;
      print('responseresponseresponseresponse${searchTripeList}');

      // Save this search to recent searches
      await saveCurrentSearch();

      update();
      Get.to(() => SearchTripsScreen());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoadingSearchTripe.value = false;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoadingSearchTripe.value = false;
      });
    }
  }

  List<Category> categoryList = [];

  Future<void> getCategoryList(int offset) async {
    Response response = await addCarServiceInterface.getCategoryList(offset);
    if (response.statusCode == 200 && response.body['data'] != null) {
      categoryList.addAll(CategoryModel.fromJson(response.body).data!);
      select.addAll(categoryList.map((e) => e.name!));
      print('categoryList${categoryList}');
    }
  }
}
