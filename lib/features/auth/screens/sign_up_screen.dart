import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/common_widgets/custom_text_field.dart';
import 'package:hoooob_app/features/auth/controllers/auth_controller.dart';
import 'package:hoooob_app/features/auth/domain/models/sign_up_body.dart';
import 'package:hoooob_app/features/auth/widgets/test_field_title.dart';
import 'package:hoooob_app/helper/display_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode referralNode = FocusNode();

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().countryDialCode =
    '+20' /* CountryCode.fromCountryCode(Get.find<ConfigController>().config!.countryCode!).dialCode! */;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        appBar: AppBarWidget(
          title: 'sign_up'.tr,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeOverLarge,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    'sign_up'.tr,
                    style: textBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeOverLarge,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    'sign_up_message'.tr,
                    maxLines: 2,
                    style: textMedium.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeLarge),
                            Image.asset(Images.signUpScreenLogo, width: 200),
                          ])),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  CustomTextField(
                    capitalization: TextCapitalization.words,
                    hintText: 'first_name'.tr,
                    inputType: TextInputType.name,
                    controller: fNameController,
                    focusNode: fNameNode,
                    nextFocus: lNameNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                    borderRadius: 15,
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeDefault,
                    height: Dimensions.paddingSizeLarge,
                  ),
                  CustomTextField(
                    capitalization: TextCapitalization.words,
                    hintText: 'last_name'.tr,
                    inputType: TextInputType.name,
                    controller: lNameController,
                    focusNode: lNameNode,
                    nextFocus: phoneNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                    borderRadius: 15,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  CustomTextField(
                    // prefixIcon: countryDialCode,
                    hintText: 'phone'.tr,
                    inputType: TextInputType.number,
                    countryDialCode: authController.countryDialCode,
                    controller: phoneController,
                    focusNode: phoneNode,
                    nextFocus: passwordNode,
                    inputAction: TextInputAction.next,
                    borderRadius: 15,
                    onCountryChanged: (CountryCode countryCode) {
                      authController.countryDialCode = countryCode.dialCode!;
                      authController.setCountryCode(countryCode.dialCode!);
                      FocusScope.of(context).requestFocus(phoneNode);
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  CustomTextField(
                    hintText: 'enter_password'.tr,
                    inputType: TextInputType.text,
                    isPassword: true,
                    controller: passwordController,
                    focusNode: passwordNode,
                    nextFocus: confirmPasswordNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                    borderRadius: 15,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  CustomTextField(
                    hintText: 'enter_confirm_password'.tr,
                    inputType: TextInputType.text,
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordNode,
                    nextFocus: referralNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                    isPassword: true,
                    borderRadius: 15,
                  ),
                  // if (Get.find<ConfigController>()
                  //         .config
                  //         ?.referralEarningStatus ??
                  //     false) ...[
                  //   TextFieldTitle(title: 'refer_code'.tr),
                  //   CustomTextField(
                  //     hintText: 'refer_code'.tr,
                  //     inputType: TextInputType.text,
                  //     controller: referralCodeController,
                  //     focusNode: referralNode,
                  //     inputAction: TextInputAction.done,
                  //     prefixIcon: Images.referralIcon1,
                  //     prefixHeight: 70,
                  //   ),
                  // ],
                  const SizedBox(height: Dimensions.paddingSizeDefault * 3),
                  authController.isLoading
                      ? Center(
                      child: SpinKitCircle(
                          color: Theme.of(context).primaryColor,
                          size: 40.0))
                      : ButtonWidget(
                    buttonText: 'sign_up'.tr,
                    radius: 50,
                    onPressed: () {
                      String fName = fNameController.text.trim();
                      String lName = lNameController.text.trim();
                      String phone = phoneController.text.trim();
                      String password = passwordController.text.trim();
                      String confirmPassword =
                      confirmPasswordController.text.trim();

                      if (fName.isEmpty) {
                        showCustomSnackBar('first_name_is_required'.tr);
                        FocusScope.of(context).requestFocus(fNameNode);
                      } else if (lName.isEmpty) {
                        showCustomSnackBar('last_name_is_required'.tr);
                        FocusScope.of(context).requestFocus(lNameNode);
                      } else if (phone.isEmpty) {
                        showCustomSnackBar('phone_is_required'.tr);
                        FocusScope.of(context).requestFocus(phoneNode);
                      } else if (!PhoneNumber.parse(
                          authController.countryDialCode + phone)
                          .isValid(type: PhoneNumberType.mobile)) {
                        showCustomSnackBar(
                            'phone_number_is_not_valid'.tr);
                        FocusScope.of(context).requestFocus(phoneNode);
                      } else if (password.isEmpty) {
                        showCustomSnackBar('password_is_required'.tr);
                        FocusScope.of(context).requestFocus(passwordNode);
                      } else if (password.length < 8) {
                        showCustomSnackBar(
                            'minimum_password_length_is_8'.tr);
                        FocusScope.of(context).requestFocus(passwordNode);
                      } else if (confirmPassword.isEmpty) {
                        showCustomSnackBar(
                            'confirm_password_is_required'.tr);
                        FocusScope.of(context)
                            .requestFocus(confirmPasswordNode);
                      } else if (password != confirmPassword) {
                        showCustomSnackBar('password_is_mismatch'.tr);
                        FocusScope.of(context)
                            .requestFocus(confirmPasswordNode);
                      } else {
                        authController.register(SignUpBody(
                            fName: fName,
                            lName: lName,
                            phone: authController.countryDialCode + phone,
                            password: password,
                            confirmPassword: confirmPassword,
                            referralCode:
                            referralCodeController.text.trim()));
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '${'already_have_an_account'.tr} ',
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('login'.tr,
                          style: textRegular.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}