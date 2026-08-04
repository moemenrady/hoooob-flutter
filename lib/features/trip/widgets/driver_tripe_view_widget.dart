import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/trip/controllers/trip_controller.dart';
import 'package:hoooob_app/features/trip/widgets/driver_tripe_item_widget.dart';
import 'package:hoooob_app/features/trip/widgets/tripe_shimmer_effect_widget.dart';
import 'package:hoooob_app/common_widgets/choose_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class DriverTripeViewWidget extends StatefulWidget {
  const DriverTripeViewWidget({super.key});

  @override
  State<DriverTripeViewWidget> createState() => _DriverTripeViewWidgetState();
}

class _DriverTripeViewWidgetState extends State<DriverTripeViewWidget> {
  @override
  void initState() {
    super.initState();
    Get.find<TripeController>().driverGetAllTripe();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripeController>(
      builder: (tripeController) {
        return ValueListenableBuilder(
          valueListenable: tripeController.driverAllTripeListLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return TripeShimmerEffectWidget();
            }

            // Status filter tabs
            List<String> statusFilters = [
              'all'.tr,
              'pending'.tr,
              'ongoing'.tr,
              'completed'.tr,
            ];

            return Column(
              children: [
                // Status Filter Tabs

                Expanded(
                  child: tripeController.filteredDriverTrips.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          itemCount: tripeController.filteredDriverTrips.length,
                          itemBuilder: (context, index) {
                            return DriverTripeItemWidget(
                              driverTripData:
                                  tripeController.filteredDriverTrips,
                              index: index,
                              tripController: tripeController,
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Theme.of(context).hintColor,
          ),
          SizedBox(height: Dimensions.paddingSizeDefault),
          Text(
            'no_trips_found'.tr,
            style: textMedium.copyWith(
              fontSize: Dimensions.fontSizeLarge,
              color: Theme.of(context).hintColor,
            ),
          ),
          SizedBox(height: Dimensions.paddingSizeSmall),
          Text(
            'no_trips_description'.tr,
            style: textRegular.copyWith(
              color: Theme.of(context).hintColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
