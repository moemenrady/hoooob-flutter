import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/add_tripe/screens/add_tripe_screen.dart';
import 'package:hoooob_app/features/dashboard/domain/models/navigation_model.dart';
import 'package:hoooob_app/features/home/screens/home_screen.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';
import 'package:hoooob_app/features/notification/screens/notification_screen.dart';
import 'package:hoooob_app/features/profile/controllers/profile_controller.dart';
import 'package:hoooob_app/features/profile/screens/profile_screen.dart';
import 'package:hoooob_app/features/trip/screens/tripe_screen.dart';
import 'package:hoooob_app/util/animation_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/features/dashboard/controllers/bottom_menu_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

@override
void initState() {
  super.initState();

  if (Get.find<LocationController>().getUserAddress() == null) {
    Future.delayed(const Duration(milliseconds: 300), () {
      _showLocationPrompt();

    });
  }
}

void _showLocationPrompt() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return AnimationHelper.sectionAnimation(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('use_current_location'.tr, style: textRegular),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  await Get.find<LocationController>().checkPermission(() async {
                    // Get.find<ProfileController>().saveUserAddress();
                    Navigator.pop(context);
                  });
                },
                child: Text('allow'.tr),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final List<NavigationModel> item = [
      NavigationModel(
        name: 'search'.tr,
        activeIcon: Images.navCarIcon,
        inactiveIcon: Images.navCarIcon,
        screen: const HomeScreen(),
      ),
      NavigationModel(
        name: 'my_trips'.tr,
        activeIcon: Images.navCalenderIcon,
        inactiveIcon: Images.navCalenderIcon,
        screen: const TripeScreen(fromProfile: false),
      ),
      NavigationModel(
        name: 'publish'.tr,
        activeIcon: Images.publishIcon,
        inactiveIcon: Images.publishIcon,
        screen: const AddTripeScreen(),
      ),
      NavigationModel(
        name: 'notifications'.tr,
        activeIcon: Images.navNotificationIcon,
        inactiveIcon: Images.navNotificationIcon,
        screen: const NotificationScreen(),
      ),
      NavigationModel(
        name: 'profile'.tr,
        activeIcon: Images.navProfileIcon,
        inactiveIcon: Images.navProfileIcon,
        screen: const ProfileScreen(),
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, val) async {
        if (Get.find<BottomMenuController>().currentTab != 0) {
          Get.find<BottomMenuController>().setTabIndex(0);
          return;
        } else {
          Get.find<BottomMenuController>().exitApp();
        }
        return;
      },
      child: GetBuilder<BottomMenuController>(builder: (menuController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            PageStorage(
                bucket: bucket, child: item[menuController.currentTab].screen),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  EdgeInsets.zero,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, -1),
                        blurRadius: 4,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.4),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: generateBottomNavigationItems(
                            menuController, item)),
                  ),
                ),
              ),
            )),
          ]),
        );
      }),
    );
  }

  List<Widget> generateBottomNavigationItems(
      BottomMenuController menuController, List<NavigationModel> item) {
    List<Widget> items = [];
    for (int index = 0; index < item.length; index++) {
      items.add(Expanded(
          child: CustomMenuItem(
        isSelected: menuController.currentTab == index,
        name: item[index].name,
        activeIcon: item[index].activeIcon,
        inActiveIcon: item[index].inactiveIcon,
        onTap: () => menuController.setTabIndex(index),
      )));
    }
    return items;
  }
}

class CustomMenuItem extends StatelessWidget {
  final bool isSelected;
  final String name;
  final String activeIcon;
  final String inActiveIcon;
  final VoidCallback onTap;

  const CustomMenuItem({
    super.key,
    required this.isSelected,
    required this.name,
    required this.activeIcon,
    required this.inActiveIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
            decoration: BoxDecoration(
                // color: Colors.teal,
                borderRadius: isSelected ? BorderRadius.circular(20) : null),
            // width: isSelected ? 90 : 50,
            height: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Image.asset(
                    isSelected ? activeIcon : inActiveIcon,
                    color: isSelected
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).textTheme.bodySmall!.color,
                    width: Dimensions.menuIconSize,
                    height: Dimensions.menuIconSize,
                  ),
                ),
                Text(name.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textRegular.copyWith(
                        color: isSelected
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).textTheme.bodySmall!.color,
                        fontSize: Dimensions.fontSizeSmall-0.3)),
              ],
            )),
      ),
    );
  }
}

final List<NavigationModel> item = [
  NavigationModel(
    name: 'home'.tr,
    activeIcon: Images.navCarIcon,
    inactiveIcon: Images.navCarIcon,
    screen: const HomeScreen(),
  ),
  NavigationModel(
    name: 'activity'.tr,
    activeIcon: Images.navCalenderIcon,
    inactiveIcon: Images.navCalenderIcon,
    screen: const TripeScreen(fromProfile: false),
  ),
  NavigationModel(
    name: 'notification'.tr,
    activeIcon: Images.navNotificationIcon,
    inactiveIcon: Images.navNotificationIcon,
    screen: const NotificationScreen(),
  ),
  NavigationModel(
    name: 'profile'.tr,
    activeIcon: Images.navProfileIcon,
    inactiveIcon: Images.navProfileIcon,
    screen: const ProfileScreen(),
  ),
];
