import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/custom_text_field.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';

class AddTripePriceFailedWidget extends StatelessWidget {
  const AddTripePriceFailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTripeController>(
      builder: (addTripeController) {
        return CustomTextField(
          capitalization: TextCapitalization.words,
          hintText: ' price'.tr,
          inputType: TextInputType.name,
          controller: addTripeController.priceController,
          // focusNode: fNameNode,
          // nextFocus: 'lNameNode',
          inputAction: TextInputAction.next,
          prefixHeight: 70,
          borderRadius: 15,
        );
      },
    );
  }
}
