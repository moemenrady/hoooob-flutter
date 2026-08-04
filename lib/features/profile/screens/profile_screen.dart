import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/features/home/widgets/app_card.dart';
import 'package:hoooob_app/features/my_vehicle/screens/not_have_vehicle_screen.dart';
import 'package:hoooob_app/features/message/screens/message_list.dart';
import 'package:hoooob_app/features/profile/widgets/profile_item.dart';
import 'package:hoooob_app/features/settings/screens/setting_screen.dart';
import 'package:hoooob_app/features/trip/screens/tripe_screen.dart';
import 'package:hoooob_app/util/animation_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:hoooob_app/features/auth/controllers/auth_controller.dart';
import 'package:hoooob_app/features/profile/controllers/profile_controller.dart';
import 'package:hoooob_app/features/profile/screens/edit_profile_screen.dart';
import 'package:hoooob_app/features/splash/controllers/config_controller.dart';
import 'package:hoooob_app/features/wallet/screens/wallet_screen.dart';
import 'package:hoooob_app/common_widgets/confirmation_dialog_widget.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/image_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (profileController) {
        var size = MediaQuery.of(context).size;
        return BodyWidget(
          
          isProfileScreen: true,
          appBar: AppBarWidget(
            isShowIcon: false,
            title: 'profile',
            toolbarHeight: 80,
            fontWeight: FontWeight.w900,
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [
              Stack(clipBehavior: Clip.none, children: [
                AnimationHelper.sectionAnimation(
                    child: AppCard(
                  child: Row(
                    children: [
                      // Profile Image
                      AnimationHelper.bounceInLeft(
                        child: InkWell(
                          onTap: () => Get.to(() => const EditProfileScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.transparent, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ImageWidget(
                                height: 70,
                                width: 70,
                                image: profileController
                                            .profileModel?.data?.profileImage !=
                                        null
                                    ? '${Get.find<ConfigController>().config!.imageBaseUrl!.profileImage}/'
                                        '${profileController.profileModel?.data?.profileImage ?? ''}'
                                    : '',
                                placeholder: Images.personPlaceholder,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimationHelper.slideRight(
                        delay: const Duration(milliseconds: 200),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSize,
                              horizontal: Dimensions.paddingSizeSmall),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController.customerName(),
                                  style: textBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      fontWeight: FontWeight.w900,
                                      color: Get.isDarkMode
                                          ? Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .color!
                                          : Theme.of(context).primaryColor),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                _buildColumnItem(
                                  'total_ride',
                                  '${profileController.profileModel?.data?.totalRideCount ?? 0}',
                                  context,
                                ),
                                Row(children: [
                                  Text(
                                    '${"your_rating".tr} :'.tr,
                                    style: textRegular.copyWith(
                                      color: Get.isDarkMode
                                          ? Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .color!
                                          : Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  Text(
                                    profileController
                                            .profileModel!.data!.userRating ??
                                        "0",
                                    style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        letterSpacing: 3,
                                        color: Get.isDarkMode
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .color!
                                            : Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    "stars".tr,
                                    style: textRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Get.isDarkMode
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .color!
                                            : Theme.of(context).primaryColor),
                                  )
                                ]),
                              ]),
                        ),
                      ),

                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault),
                          child: SvgPicture.asset(Images.rightArrowSvg)),
                    ],
                  ),
                )),
              ]),
              SizedBox(height: size.height * .01),
              AnimationHelper.cardAnimation(
                index: 0,
                child: ProfileMenuItem(
                  title: 'my_vehicle'.tr,
                  icon: Images.truckIcon,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotHaveVehicleCarScreen(),
                    ),
                  ),
                ),
              ),
              AnimationHelper.cardAnimation(
                index: 1,
                child: ProfileMenuItem(
                  title: 'message',
                  icon: Images.messageQuestionIcon,
                  onTap: () => Get.to(() => const MessageListScreen()),
                ),
              ),
              // ProfileMenuItem(
              //   title: 'profile',
              //   icon: Images.taskIcon,
              //   onTap: () => Get.to(() => const EditProfileScreen()),
              // ),

              // ProfileMenuItem(
              //   title: 'my_address',
              //   icon: Images.location,
              //   onTap: () => Get.to(() => const MyAddressScreen()),
              // ),

              AnimationHelper.cardAnimation(
                index: 2,
                child: ProfileMenuItem(
                  title: 'my_wallet',
                  icon: Images.messageQuestionIcon,
                  onTap: () => Get.to(() => const WalletScreen()),
                ),
              ),
              // ProfileMenuItem(
              //   title: 'my_offer',
              //   icon: Images.peopleIcon,
              //   onTap: () => Get.to(() => MyOfferScreen()),
              // ),
              // ProfileMenuItem(
              //   title: 'my_trips',
              //   icon: Images.peopleIcon,
              //   onTap: () => Get.to(() => const TripeScreen(fromProfile: true)),
              // ),
              if ((Get.find<ConfigController>().config?.referralEarningStatus ??
                      false) ||
                  ((Get.find<ProfileController>()
                              .profileModel
                              ?.data
                              ?.wallet
                              ?.referralEarn ??
                          0) >
                      0))
                // ProfileMenuItem(
                //   title: 'refer_and_earn',
                //   icon: Images.referralIcon1,
                //   onTap: () => Get.to(() => const ReferAndEarnScreen()),
                // ),
                // if (Get.find<ConfigController>().config?.levelStatus ?? false)
                //   ProfileMenuItem(
                //     title: 'my_level',
                //     icon: Images.myLevelIcon,
                //     onTap: () => Get.to(() => const MyLevelScreen()),
                //   ),
                // ProfileMenuItem(
                //   title: 'help_support',
                //   icon: Images.profileHelpSupport,
                //   onTap: () => Get.to(() => const HelpAndSupportScreen()),
                // ),
                AnimationHelper.cardAnimation(
                  index: 3,
                  child: ProfileMenuItem(
                    title: 'settings',
                    icon: Images.peopleIcon,
                    onTap: () => Get.to(() => const SettingScreen()),
                  ),
                ),
              AnimationHelper.cardAnimation(
                index: 4,
                child: ProfileMenuItem(
                  title: 'privacy_settings',
                  icon: Images.peopleIcon,
                  onTap: () => Get.to(() => const SettingScreen()),
                ),
              ),
              AnimationHelper.cardAnimation(
                index: 5,
                child: ProfileMenuItem(
                  title: 'delete_account',
                  icon: Images.trash2Icon,
                  onTap: () => Get.to(() => const SettingScreen()),
                ),
              ),
              // ProfileMenuItem(
              //   title: 'privacy_policy',
              //   icon: Images.privacyPolicyIcon,
              //   onTap: () => Get.to(() => PolicyScreen(
              //         htmlType: HtmlType.privacyPolicy,
              //         image: Get.find<ConfigController>()
              //                 .config
              //                 ?.privacyPolicy
              //                 ?.image ??
              //             '',
              //       )),
              // ),
              // ProfileMenuItem(
              //   title: 'refund_policy',
              //   icon: Images.privacyPolicyIcon,
              //   onTap: () => Get.to(() => PolicyScreen(
              //         htmlType: HtmlType.refundPolicy,
              //         image: Get.find<ConfigController>()
              //                 .config
              //                 ?.refundPolicy
              //                 ?.image ??
              //             '',
              //       )),
              // ),
              // ProfileMenuItem(
              //   title: 'terms_and_condition',
              //   icon: Images.termsAndCondition,
              //   onTap: () => Get.to(() => PolicyScreen(
              //         htmlType: HtmlType.termsAndConditions,
              //         image: Get.find<ConfigController>()
              //                 .config
              //                 ?.termsAndConditions
              //                 ?.image ??
              //             '',
              //       )),
              // ),
              // ProfileMenuItem(
              //   title: 'legal',
              //   icon: Images.privacyPolicy,
              //   onTap: () => Get.to(() => PolicyScreen(
              //         htmlType: HtmlType.legal,
              //         image:
              //             Get.find<ConfigController>().config?.legal?.image ??
              //                 '',
              //       )),
              // ),
              AnimationHelper.cardAnimation(
                index: 6,
                child: ProfileMenuItem(
                  title: 'logout',
                  icon: Images.peopleIcon,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black54,
                      builder: (_) {
                        return GetBuilder<AuthController>(
                          builder: (authController) {
                            return AnimationHelper.dialogAnimation(
                              child: ConfirmationDialogWidget(
                                icon: Images.profileLogout,
                                isLoading: authController.isLoading,
                                description:
                                    'do_you_want_to_log_out_this_account'.tr,
                                onYesPressed: () {
                                  Get.find<AuthController>().logOut();
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              AnimationHelper.cardAnimation(
                index: 7,
                child: ProfileMenuItem(
                  title: 'permanently_delete_account'.tr,
                  icon: Images.peopleIcon,
                  divider: false,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return GetBuilder<AuthController>(
                          builder: (authController) {
                            return ConfirmationDialogWidget(
                              icon: Images.profileLogout,
                              isLoading: authController.isLoading,
                              description:
                                  'are_you_sure_permanent_delete_smg'.tr,
                              onYesPressed: () {
                                Get.find<AuthController>().permanentlyDelete();
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge * 4),
            ]),
          ),
        );
      }),
    );
  }

  Row _buildColumnItem(String title, String value, BuildContext context) {
    return Row(children: [
      Text(title.tr,
          style: textMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w500)),
      const SizedBox(height: Dimensions.paddingSizeSmall),
      Text(value,
          style: textBold.copyWith(
              color: Theme.of(context).primaryColorDark,
              fontSize: Dimensions.fontSizeExtraLarge,
              fontWeight: FontWeight.w600)),
    ]);
  }

  Widget _animatedItem({
    required Widget child,
    required int index,
  }) {
    if (index.isEven) {
      return AnimationHelper.leftCardAnimation(
        child: child,
        index: index,
      );
    } else {
      return AnimationHelper.rightCardAnimation(
        child: child,
        index: index,
      );
    }
  }
}
