import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/image_title_subtitle.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_details_drop_down_widget.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_details_text_widget.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_details_from_to_widget.dart';
import 'package:hoooob_app/features/home/controllers/add_car_controller.dart';
import 'package:hoooob_app/features/my_vehicle/screens/add_vehicle_car_screen.dart';
import 'package:hoooob_app/features/my_vehicle/screens/my_vehicle_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';

class AddTripeScreen extends StatefulWidget {
  const AddTripeScreen({super.key});

  @override
  State<AddTripeScreen> createState() => _AddTripeScreenState();
}

class _AddTripeScreenState extends State<AddTripeScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<AddTripeController>().getAllVehicles();
    _checkVehicleStatus();
  }

  Future<void> _checkVehicleStatus() async {
    final controller = Get.find<AddCarController>();
    await controller.getVehicleList();
    await controller.getVehicleCategoryList(); // Load categories too
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<AddTripeController>(builder: (addTripeController) {
      return GetBuilder<AddCarController>(builder: (addCarController) {
        return Scaffold(
          body: BodyWidget(
            appBar: AppBarWidget(
              showBackButton: false,
              title: 'title',
              height: 10,
            ),
            body: addCarController.hasVehicles
                ? Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSize),
                    child: ValueListenableBuilder(
                      valueListenable: addTripeController.isFromToDetails,
                      builder: (context, isFormTo, child) =>
                          SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.width * 0.03),
                            AddTripeDetailsTextWidget(),
                            SizedBox(height: size.width * 0.03),
                            isFormTo
                                ? AddTripeDetailsFromToWidget()
                                : AddTripeDetailsDropDownWidget(),
                          ],
                        ),
                      ),
                    ),
                  )
                : ImageTitleSubTitle(
                    title: 'not_have_car'.tr,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddVehicleScreen()));
                      addCarController.isHaveCar.value = true;
                    },
                  ),
          ),
        );
      });
    });
  }
}
