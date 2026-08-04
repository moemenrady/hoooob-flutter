import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/image_title_subtitle.dart';
import 'package:hoooob_app/features/home/controllers/add_car_controller.dart';
import 'package:hoooob_app/features/my_vehicle/screens/add_vehicle_car_screen.dart';
import 'package:hoooob_app/features/my_vehicle/screens/my_vehicle_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:get/get.dart';

class NotHaveVehicleCarScreen extends StatefulWidget {
  const NotHaveVehicleCarScreen({super.key});

  @override
  State<NotHaveVehicleCarScreen> createState() =>
      _NotHaveVehicleCarScreenState();
}

class _NotHaveVehicleCarScreenState extends State<NotHaveVehicleCarScreen> {
  @override
  void initState() {
    super.initState();
    // Check if user has vehicles when screen loads
    _checkVehicleStatus();
  }

  Future<void> _checkVehicleStatus() async {
    final controller = Get.find<AddCarController>();
    await controller.getVehicleList();
    await controller.getVehicleCategoryList(); // Load categories too

    // If user has vehicles, navigate to vehicle list screen
    if (controller.hasVehicles) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const MyVehicleScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<AddCarController>(builder: (profileController) {
      // Show loading while checking vehicle status
      if (profileController.isLoadingVehicles) {
        return Scaffold(
          body: BodyWidget(
            appBar: AppBarWidget(
              isBackButtonShow: true,

              toolbarHeight: size.height * 0.1,
              isShowIcon: true,
              fontSize: Dimensions.fontSizeOverLarge,
              fontWeight: FontWeight.w900,
              title: 'vehicle_setup'.tr,
              height: 0,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }

      // Show "no vehicle" content if user has no vehicles
      return Scaffold(
        body: BodyWidget(
          appBar: AppBarWidget(
            isBackButtonShow: true,
            toolbarHeight: size.height * 0.1,
            isShowIcon: true,
            fontSize: Dimensions.fontSizeOverLarge,
            fontWeight: FontWeight.w900,
            title: 'vehicle_setup'.tr,
            height: 0,
          ),
          body: ImageTitleSubTitle(
            title: 'not_have_car'.tr,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddVehicleScreen()));
              profileController.isHaveCar.value = true;
            },
          ),
        ),
      );
    });
  }
}
