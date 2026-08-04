import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/custom_pop_scope_widget.dart';
import 'package:hoooob_app/common_widgets/choose_widget.dart';
import 'package:hoooob_app/features/trip/widgets/driver_tripe_view_widget.dart';
import 'package:hoooob_app/features/trip/widgets/trip_item_view.dart';
import 'package:hoooob_app/features/trip/widgets/user_tripe_view.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/features/trip/controllers/trip_controller.dart';
import 'package:hoooob_app/features/notification/widgets/notification_shimmer.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/no_data_widget.dart';
import 'package:hoooob_app/common_widgets/paginated_list_widget.dart';
import 'package:hoooob_app/util/styles.dart';

class TripeScreen extends StatefulWidget {
  final bool fromProfile;

  const TripeScreen({super.key, required this.fromProfile});

  @override
  State<TripeScreen> createState() => _TripeScreenState();
}

class _TripeScreenState extends State<TripeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    tabController = TabController(
        length: 3, vsync: this); // Changed to 3 tabs for trip status
    Get.find<TripeController>().initData();
    Get.find<TripeController>().getTripList(1);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        // Set trip status filter based on tab index
        switch (tabController.index) {
          case 0:
            Get.find<TripeController>().setTripStatusFilter('pending');
            break;
          case 1:
            Get.find<TripeController>().setTripStatusFilter('ongoing');
            break;
          case 2:
            Get.find<TripeController>().setTripStatusFilter('completed');
            break;
        }
      }
    });
    super.initState();
    Get.find<TripeController>().driverGetAllTripe();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<String> user = [
    "كمستخدم",
    "كسائق",
  ];
  List<Widget> screens = [
    Expanded(child: UserTripeViewWidget()),
    Expanded(child: DriverTripeViewWidget()),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      child: Scaffold(
        body: BodyWidget(
          appBar: AppBarWidget(
              title: 'trip_history'.tr,
              showBackButton: widget.fromProfile,
              centerTitle: true,
              showTripHistoryFilter: true),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: GetBuilder<TripeController>(builder: (tripController) {
              return Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('my_travels'.tr, style: textBold.copyWith(fontSize: 20)),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  // Trip Status Filter Tabs
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).hintColor,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: 3,
                      labelStyle: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                      unselectedLabelStyle: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                      tabs: [
                        Tab(text: 'pending'.tr),
                        Tab(text: 'ongoing'.tr),
                        Tab(text: 'completed'.tr),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  // User Type Selection
                  Expanded(
                    child: ChooseWidget(
                      nameList: user,
                      nameWidget: screens,
                    ),
                  ),
                ],
              );

              // Column(children: [
              // TabBar(
              //   controller: tabController,
              //   unselectedLabelColor: Colors.grey,
              //   tabAlignment: TabAlignment.start,
              //   isScrollable: true,
              //   labelColor: Get.isDarkMode ? Colors.white.withOpacity(0.9) : Theme.of(context).primaryColor,
              //   labelStyle: textSemiBold.copyWith(),
              //   indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
              //   dividerHeight: 1,
              //   dividerColor: Theme.of(context).primaryColor.withOpacity(0.15),
              //   tabs: [
              //     Tab(text: 'all_trip'.tr),
              //     Tab(text: 'ongoing'.tr),
              //     Tab(text: 'cancelled'.tr),
              //     Tab(text: 'completed'.tr),
              //     Tab(text: 'returned'.tr)
              //   ],
              // ),

              // Expanded(child: TabBarView(
              //     controller: tabController,
              //     children: [
              //       tabBarBodyWidget(tripController),
              //       tabBarBodyWidget(tripController),
              //       tabBarBodyWidget(tripController),
              //       tabBarBodyWidget(tripController),
              //       tabBarBodyWidget(tripController)
              //     ]
              // ))
              // Expanded(child: MyTripeViewWidget()),
              // ]);
            }),
          ),
        ),
      ),
    );
  }

  Widget tabBarBodyWidget(TripeController tripController) {
    return (tripController.tripModel != null &&
            tripController.tripModel!.data != null)
        ? tripController.tripModel!.data!.isNotEmpty
            ? SingleChildScrollView(
                controller: scrollController,
                child: PaginatedListWidget(
                  scrollController: scrollController,
                  totalSize: tripController.tripModel!.totalSize,
                  offset: (tripController.tripModel != null &&
                          tripController.tripModel!.offset != null)
                      ? int.parse(tripController.tripModel!.offset.toString())
                      : null,
                  onPaginate: (int? offset) async {
                    await tripController.getTripList(offset!);
                  },
                  itemView: Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: ListView.separated(
                      itemCount: tripController.tripModel!.data!.length,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return TripItemView(
                            tripDetails:
                                tripController.tripModel!.data![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.15)),
                    ),
                  ),
                ),
              )
            : const NoDataWidget(title: 'no_trip_found')
        : const NotificationShimmer();
  }
}
