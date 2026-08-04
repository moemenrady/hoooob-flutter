import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hoooob_app/common_widgets/custom_snackbar.dart';
import 'package:hoooob_app/common_widgets/image_title_subtitle.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/cancel_and_start_tripe_request.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/reservation_tripe_request_model.dart';
import 'package:hoooob_app/features/details_tripe/domain/services/details_tripe_services_interface.dart';

class DetailsTripeController extends GetxController implements GetxService {
  final DetailsTripeServiceInterface detailsTripeServiceInterface;

  DetailsTripeController({required this.detailsTripeServiceInterface});

  ValueNotifier<bool> isLoadingReservationTripe = ValueNotifier(false);
  ValueNotifier<bool> isLoadingAcceptTripe = ValueNotifier(false);
  ValueNotifier<bool> isLoadingCancelTripe = ValueNotifier(false);

  int? routeId;
  int? seatsCount;
  double? startLat;
  double? startLng;
  double? endLat;
  double? endLng;
  int? price;

  void reservationTripe() async {
    isLoadingReservationTripe.value = true;
    Response response = await detailsTripeServiceInterface.reservationTripe(
      ReservationTripeRequestModel(
        routeId: routeId!,
        seatsCount: seatsCount!,
        pickupLat: startLat!,
        pickupLng: startLng!,
        dropOffLat: endLat!,
        dropOffLng: endLng!,
        price: price!,
      ),
    );
    if (response.statusCode == 200) {
      isLoadingReservationTripe.value = false;
      Get.to(
        () => ImageTitleSubTitle(
          title: 'send_request_success'.tr,
          subTitle: 'send_request_success_to_driver'.tr,
        ),
      );

      print('==============>success');
    } else {
      isLoadingReservationTripe.value = false;
      String errorMessage = '';
      errorMessage = response.body['data']['message'];
      customSnackBar(errorMessage, isError: true);
    }
  }

  void stateLoadingTripe(String stateTripe, bool val) {
    if (stateTripe == 'reject') {
      isLoadingCancelTripe.value = val;
    } else {
      isLoadingAcceptTripe.value = val;
    }
  }

  void cancelAndAcceptTripe(
      {required int passengerId, required String stateTripe}) async {
    stateLoadingTripe(stateTripe, true);
    Response response = await detailsTripeServiceInterface.cancelAndAcceptTripe(
      CancelAmdStartTripeRequestModel(
        passengerId: passengerId,
        stateTripe: stateTripe,
      ),
    );
    if (response.statusCode == 200) {
      stateLoadingTripe(stateTripe, false);
    } else {
      stateLoadingTripe(stateTripe, false);
    }
  }
}
