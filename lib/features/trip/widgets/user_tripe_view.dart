import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/trip/controllers/trip_controller.dart';
import 'package:hoooob_app/features/trip/widgets/tripe_shimmer_effect_widget.dart';
import 'package:hoooob_app/features/trip/widgets/user_tripe_item.dart';

class UserTripeViewWidget extends StatefulWidget {
  const UserTripeViewWidget({super.key});

  @override
  State<UserTripeViewWidget> createState() => _UserTripeViewWidgetState();
}

class _UserTripeViewWidgetState extends State<UserTripeViewWidget> {
  @override
  void initState() {
    super.initState();
    Get.find<TripeController>().passengersGetAllTripe();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripeController>(builder: (userController) {
      return ValueListenableBuilder(
        valueListenable: userController.passengersAllTripeListLoading,
        builder: (context, isLoading, child) {
          return isLoading
              ? TripeShimmerEffectWidget()
              : ListView.builder(
                  itemCount: userController.passengersAllTripeList.length,
                  itemBuilder: (context, index) => UserTripeItem(
                      index: index,
                      passengerTripe: userController.passengersAllTripeList),
                );
        },
      );
    });
  }
}
