import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:intl/intl.dart';

class AddTripeButtonFromToWidget extends StatefulWidget {
  const AddTripeButtonFromToWidget({super.key});

  @override
  State<AddTripeButtonFromToWidget> createState() =>
      _AddTripeButtonFromToWidgetState();
}

class _AddTripeButtonFromToWidgetState
    extends State<AddTripeButtonFromToWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<AddTripeController>(
      builder: (addTripeController) {
        return GetBuilder<LocationController>(
          builder: (locationController) {
            return ButtonWidget(
                width: size.width * 0.3 + 5,
                height: size.height * 0.03 + 5,
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_validateTripData(
                      addTripeController, locationController)) {
                    actionTheTapButton(addTripeController, locationController);
                  }
                },
                buttonText: 'continue2'.tr);
          },
        );
      },
    );
  }

  bool _validateTripData(
    AddTripeController addTripeController,
    LocationController locationController,
  ) {
    if (locationController.pickupLocationController.text.isEmpty) {
      showCustomSnackBar('pickup_location_is_required'.tr);
      return false;
    }

    if (locationController.destinationLocationController.text.isEmpty) {
      showCustomSnackBar('destination_location_is_required'.tr);
      return false;
    }

    if (locationController.addPassengersController.text.isEmpty) {
      showCustomSnackBar('please_add_passengers'.tr);
      return false;
    }

    if (locationController.dateController.text.isEmpty) {
      showCustomSnackBar('please_select_date'.tr);
      return false;
    }

    return true;
  }

  void actionTheTapButton(AddTripeController addTripeController,
      LocationController locationController) {
    addTripeController.isFromToDetails.value = false;
    addTripeController.startLat = locationController.fromAddress!.latitude;
    addTripeController.startLng = locationController.fromAddress!.longitude;
    addTripeController.endLat = locationController.toAddress!.latitude;
    addTripeController.endLng = locationController.toAddress!.longitude;
    addTripeController.availableSeats =
        locationController.addPassengersController.text;
    addTripeController.startTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(locationController.dateController.text);
    addTripeController.restStops = locationController.restStopsList;
    print('111111111${addTripeController.startLat}');
    print('111111111${addTripeController.startLng}');
    print('111111111${addTripeController.endLat}');
    print('111111111${addTripeController.endLng}');
  }
}
