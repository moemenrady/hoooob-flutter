import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/choose_widget.dart';
import 'package:hoooob_app/features/home/controllers/add_car_controller.dart';
import 'package:hoooob_app/features/home/domain/models/add_car_category.dart';
import 'package:hoooob_app/features/my_vehicle/screens/not_have_vehicle_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:get/get.dart';

class MyVehicleScreen extends StatefulWidget {
  const MyVehicleScreen({super.key});

  @override
  State<MyVehicleScreen> createState() => _MyVehicleScreenState();
}

class _MyVehicleScreenState extends State<MyVehicleScreen> {
  @override
  void initState() {
    super.initState();
    // Vehicle list is already loaded by NotHaveVehicleCarScreen
    // Load categories for filtering
    Get.find<AddCarController>().getVehicleCategoryList();
  }

  List<String> _getCategoryNames(AddCarController controller) {
    List<String> categoryNames = ['all'.tr];
    categoryNames.addAll(controller.vehicleCategories
        .map((category) => category.name ?? '')
        .toList());
    return categoryNames;
  }

  void _onCategorySelected(int index, AddCarController controller) {
    if (index == 0) {
      // "All Categories" selected
      controller.filterVehiclesByCategory(null);
    } else {
      // Specific category selected
      Category selectedCategory = controller.vehicleCategories[index - 1];
      controller.filterVehiclesByCategory(selectedCategory);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, String vehicleId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete_vehicle'.tr),
          content: Text('are_you_sure_delete_vehicle'.tr),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.find<AddCarController>().deleteVehicle(vehicleId);
              },
              child: Text('delete'.tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BodyWidget(
        appBar: AppBarWidget(
          toolbarHeight: size.height * 0.1,
          isShowIcon: true,
          fontSize: Dimensions.fontSizeOverLarge,
          fontWeight: FontWeight.w900,
          title: 'my_vehicle'.tr,
          height: 0,
        ),
        body: GetBuilder<AddCarController>(builder: (controller) {
          // Show loading state
          if (controller.isLoadingVehicles) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Show "no vehicle" screen if no vehicles
          if (!controller.hasVehicles) {
            return const NotHaveVehicleCarScreen();
          }

          // Show vehicle list if vehicles exist
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              spacing: size.height * 0.02,
              children: [
                SizedBox(height: size.height * 0.02),
                ChooseWidget(
                  nameList: _getCategoryNames(controller),
                  onTap: (index) => _onCategorySelected(index, controller),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredVehicleList.length,
                    itemBuilder: (context, index) {
                      final vehicle = controller.filteredVehicleList[index];
                      return Container(
                        width: size.width,
                        height: size.height * .12,
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * .01),
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .03),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: const Offset(1, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              Images.car2Icon,
                              width: size.width * .08,
                            ),
                            SizedBox(width: size.width * .03),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${vehicle.brandName ?? 'Unknown'} ${vehicle.modelName ?? 'Unknown'}',
                                    style: textBold.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .color,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'License: ${vehicle.licencePlateNumber ?? 'N/A'}',
                                    style: textRegular.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.8),
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${vehicle.isActive == true ? 'Active' : 'Inactive'}',
                                    style: textRegular.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.8),
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showDeleteConfirmationDialog(
                                  context, vehicle.id!),
                              child: Image.asset(
                                Images.trashIcon,
                                width: size.width * .06,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
