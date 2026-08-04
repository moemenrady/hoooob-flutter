import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/common_widgets/loader_widget.dart';
import 'package:hoooob_app/features/details_tripe/controller/details_tripe_controller.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/ride/controllers/ride_controller.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/address/domain/models/address_model.dart';
import 'package:hoooob_app/features/ride/domain/models/estimated_fare_model.dart';
import 'package:hoooob_app/features/home/controllers/add_car_controller.dart';
import 'package:hoooob_app/features/home/domain/models/add_car_category.dart';

class DetailsTripeReservationButton extends StatelessWidget {
  final DetailsTripeNavigateDataModel tripeData;

  const DetailsTripeReservationButton({super.key, required this.tripeData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsTripeController>(
      builder: (detailsTripeController) {
        return ValueListenableBuilder(
            valueListenable: detailsTripeController.isLoadingReservationTripe,
            builder: (context, isLoading, child) {
              return isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04 + 5,
                      child: const LoaderWidget())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ButtonWidget(
                        buttonText: 'reservation'.tr,
                        onPressed: () {
                          actionThenTapButton(detailsTripeController);
                        },
                        fontSize: 20,
                      ),
                    );
            });
      },
    );
  }

  void actionThenTapButton(
      DetailsTripeController detailsTripeController) async {
    // Set the trip data in details controller for reference
    detailsTripeController.routeId = tripeData.routeId;
    detailsTripeController.seatsCount = tripeData.seatsAvailable;
    detailsTripeController.startLat = tripeData.startLat!;
    detailsTripeController.startLng = tripeData.startLng!;
    detailsTripeController.endLat = tripeData.endLat!;
    detailsTripeController.endLng = tripeData.endLng!;
    detailsTripeController.price = tripeData.price!.toInt();

    // Get controllers
    final rideController = Get.find<RideController>();
    final locationController = Get.find<LocationController>();

    // Set the location data in location controller to avoid null errors
    // Get zone ID from current user address to avoid zone_id required error
    final currentUserAddress = locationController.getUserAddress();
    final currentZoneId = currentUserAddress?.zoneId ?? '1';

    locationController.fromAddress = Address(
      latitude: tripeData.startLat ?? 0.0,
      longitude: tripeData.startLng ?? 0.0,
      address: tripeData.fromAddress ?? '',
      zoneId: currentZoneId,
    );

    locationController.toAddress = Address(
      latitude: tripeData.endLat ?? 0.0,
      longitude: tripeData.endLng ?? 0.0,
      address: tripeData.toAddress ?? '',
      zoneId: currentZoneId,
    );

    // Set the carpool route ID for the ride request
    rideController.carpollRouteId = tripeData.routeId.toString();

    // Get the proper vehicle category ID from the car controller
    final addCarController = Get.find<AddCarController>();
    String vehicleCategoryId = '1'; // Default fallback

    // Ensure categories are loaded first
    if (addCarController.vehicleCategories.isEmpty) {
      print('🔄 Loading vehicle categories...');
      await addCarController.getVehicleCategoryList();
    }

    // Find the category ID that matches the vehicle category from the trip data
    // The API response shows "category: Motorcycle", so we need to find the Motorcycle category ID
    print(
        '🔍 Available vehicle categories: ${addCarController.vehicleCategories.length}');
    for (var category in addCarController.vehicleCategories) {
      print('  - ${category.name} (ID: ${category.id})');
    }

    if (addCarController.vehicleCategories.isNotEmpty) {
      // Try to find Motorcycle category first
      Category? motorcycleCategory;
      for (var category in addCarController.vehicleCategories) {
        if (category.name?.toLowerCase().contains('motorcycle') == true ||
            category.name?.toLowerCase().contains('bike') == true ||
            category.name?.toLowerCase().contains('scooter') == true) {
          motorcycleCategory = category;
          break;
        }
      }

      if (motorcycleCategory != null) {
        vehicleCategoryId = motorcycleCategory.id ?? '1';
        print(
            '✅ Found motorcycle category: ${motorcycleCategory.name} (ID: $vehicleCategoryId)');
      } else {
        // If no motorcycle category found, use the first available category
        vehicleCategoryId = addCarController.vehicleCategories.first.id ?? '1';
        print(
            '⚠️ No motorcycle category found, using first category: ${addCarController.vehicleCategories.first.name} (ID: $vehicleCategoryId)');
      }
    } else {
      print(
          '❌ No vehicle categories available, using default ID: $vehicleCategoryId');
      // Use a known valid UUID format as fallback
      vehicleCategoryId = '00000000-0000-0000-0000-000000000001';
    }

    // Create a minimal FareModel with zone ID to avoid zone_id required error
    final fareModel = FareModel(
      zoneId: currentZoneId,
      vehicleCategoryId: vehicleCategoryId, // Use proper UUID category ID
      estimatedFare: tripeData.price?.toDouble() ?? 0.0,
      estimatedDistance: '0',
      estimatedDuration: '0',
      baseFare: 0.0,
      baseFarePerKm: 0.0,
      fare: tripeData.price?.toDouble() ?? 0.0,
      discountFare: 0.0,
      discountAmount: 0.0,
      couponApplicable: false,
      extraEstimatedFare: 0.0,
      extraDiscountFare: 0.0,
      extraDiscountAmount: 0.0,
      extraReturnFee: 0.0,
      extraCancellationFee: 0.0,
      extraFareAmount: 0.0,
      extraFareFee: 0.0,
    );

    // Validate that we have a proper UUID format
    final uuidRegex = RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
        caseSensitive: false);
    if (!uuidRegex.hasMatch(vehicleCategoryId)) {
      print('⚠️ Category ID is not a valid UUID format: $vehicleCategoryId');
      vehicleCategoryId = '00000000-0000-0000-0000-000000000001';
      print('🔄 Using fallback UUID: $vehicleCategoryId');
    }

    print('🎯 Final vehicle category ID: $vehicleCategoryId');

    // Set the selectedType to avoid zone_id required error
    rideController.selectedType = fareModel;
    rideController.selectedCategoryId =
        vehicleCategoryId; // Use proper UUID category ID

    // Submit the ride request as a carpool
    rideController.submitRideRequest(
      '', // note - empty for now
      false, // parcel - false for carpool
      isCarpool: true, // This is a carpool request
      categoryId: '', // category ID if needed
    );
  }
}
