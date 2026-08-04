import 'package:flutter/material.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/common_widgets/custom_alart_dialog_shape.dart';
import 'package:hoooob_app/common_widgets/custom_text_field.dart';
import 'package:hoooob_app/common_widgets/dialog_custom.dart';
import 'package:hoooob_app/common_widgets/drop_down_2_widget.dart';
import 'package:hoooob_app/common_widgets/image_dialog_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class WithdrawMoneyWidget extends StatefulWidget {
  const WithdrawMoneyWidget({super.key});

  @override
  State<WithdrawMoneyWidget> createState() => _WithdrawMoneyWidgetState();
}

List<String> _paymentMethod = [
  'وسيلة السحب',
  'انستا باي',
  'حساب بنكي ',
  'محفظة هاتف',
  'بطاقة بنكية',
  'Paypal',
  'Apple pay',
  'Google pay',
];
String? selectedValue;

class _WithdrawMoneyWidgetState extends State<WithdrawMoneyWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وسيلة السحب',
          style: textBold.copyWith(
            color: Theme.of(context).textTheme.labelLarge!.color,
            fontSize: Dimensions.fontSizeLarge,
          ),
        ),
        SizedBox(height: 15),
        DropDown2Widget(
          textColor: Theme.of(context).textTheme.labelLarge!.color,
          height: size.height * 0.05 + 6,
          pathImage: Images.arrowDown1,
          dropdownColor: Theme.of(context).cardColor,
          list: _paymentMethod,
          borderColor: Theme.of(context).focusColor,
          onChanged: (value) {
            setState(() {});
            selectedValue = value;
            print(value);
          },
        ),
        SizedBox(height: 15),
        if (selectedValue == _paymentMethod[1]) _withdrawIntaPayFailed(),
        if (selectedValue == _paymentMethod[2]) _withdrawBankAccountFailed(),
        if (selectedValue == _paymentMethod[3]) _withdrawPhoneWalletFailed(),
        if (selectedValue == _paymentMethod[4]) _withdrawBankCardFailed(),
        _withdrawMoneyField(),
        SizedBox(height: 34),
        ButtonWidget(
          buttonText: 'send_request',
          backgroundColor: Theme.of(context).primaryColor,
          width: size.width,
          height: size.height * 0.05,
          radius: 15,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DialogCustom(
                  image: Images.completed1Icon,
                  title: 'تم ارسال طلبك بنجاح',
                  subtitle: 'تم ارسال طلبك بنجاح',
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
                //   Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: size.width * 0.05,
                //       vertical: size.height * 0.17),
                //   child: Container(
                //     width: size.width * 0.01,
                //     height: size.height * 0.50,
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).cardColor,
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       spacing: 16,
                //       children: [
                //         Image.asset(
                //           Images.completed1Icon,
                //           width: size.width * 0.9,
                //         ),
                //
                //         Text(
                //           'تم ارسال طلبك بنجاح',
                //           style: textBold.copyWith(
                //               color:
                //                   Theme.of(context).textTheme.labelLarge!.color,
                //               fontSize: 20),
                //         ),
                //         Text(
                //           'تم ارسال طلبكم وسيتم اشعارك فور قبوله!',
                //           style: textMedium.copyWith(
                //               color: Theme.of(context)
                //                   .textTheme
                //                   .headlineMedium!
                //                   .color,
                //               fontSize: Dimensions.fontSizeLarge),
                //         ),
                //         ButtonWidget(
                //           buttonText: 'موافق',
                //           backgroundColor: Theme.of(context).primaryColor,
                //           width: size.width * 0.4,
                //           radius: 50,
                //         )
                //       ],
                //     ),
                //   ),
                // );
              },
            );
          },
        )
      ],
    );
  }

  Widget _withdrawMoneyField() {
    return CustomTextField(
      hintColor: Theme.of(context).hintColor,
      borderColor: Theme.of(context).focusColor,
      inputType: TextInputType.number,
      hintText: 'المبلغ المراد سحبه',
      borderRadius: 15,
    );
  }

  Widget _withdrawIntaPayFailed() {
    return Column(
      children: [
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          hintText: 'اسم المستخدم الخاص بانستا باي',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _withdrawPhoneWalletFailed() {
    return Column(
      children: [
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          hintText: 'اسم المستخدم الخاص بالمحفظة',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          inputType: TextInputType.number,
          hintText: 'رقم المحفظة',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _withdrawBankAccountFailed() {
    return Column(
      children: [
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          hintText: 'اسم المستخدم الخاص الحساب البنكي ',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          inputType: TextInputType.number,
          hintText: 'رقم الحساب البنكي',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _withdrawBankCardFailed() {
    return Column(
      children: [
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          hintText: 'اسم المستخدم الخاص البطاقة البنكية',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
        CustomTextField(
          hintColor: Theme.of(context).hintColor,
          borderColor: Theme.of(context).focusColor,
          inputType: TextInputType.number,
          hintText: 'رقم الحساب البطاقة البنكية',
          borderRadius: 15,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
