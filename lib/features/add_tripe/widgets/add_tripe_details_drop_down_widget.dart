import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/drop_down_2_widget.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_button_widget.dart';
import 'package:hoooob_app/features/add_tripe/widgets/add_tripe_price_failed_widget.dart';

class AddTripeDetailsDropDownWidget extends StatefulWidget {
  const AddTripeDetailsDropDownWidget({super.key});

  @override
  State<AddTripeDetailsDropDownWidget> createState() =>
      _AddTripeDetailsDropDownWidgetState();
}

class _AddTripeDetailsDropDownWidgetState
    extends State<AddTripeDetailsDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<AddTripeController>(builder: (addTripeController) {
      return Column(
        children: [
          AddTripePriceFailedWidget(),
          SizedBox(height: size.height * 0.02),
          ...addTripeController.detailsDropDown.entries.map((entry) {
            String key = entry.key;
            var options = entry.value;

            if (key == 'choose_from_you_car') {
              List<String> displayNames =
                  options.map((e) => e['name'].toString()).toList();

              return Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.02),
                child: DropDown2Widget(
                  list: [key.tr, ...displayNames.map((e) => e.tr)],
                  dropdownColor: Theme.of(context).cardColor,
                  borderColor: Theme.of(context).hintColor.withOpacity(0.5),
                  onChanged: (value) {
                    var selectedMap = options.firstWhere(
                        (element) => element['name'] == value,
                        orElse: () => null);
                    if (selectedMap != null) {
                      addTripeController.selectIndexDropDownMenu(
                          addTripeController, key, selectedMap['id']);
                    }
                  },
                ),
              );
            } else {
              List<String> optionsList = List<String>.from(options);

              return Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.02),
                child: DropDown2Widget(
                  list: [key.tr, ...optionsList.map((e) => e.tr)],
                  dropdownColor: Theme.of(context).cardColor,
                  borderColor: Theme.of(context).hintColor.withOpacity(0.5),
                  onChanged: (value) {
                    addTripeController.selectIndexDropDownMenu(
                        addTripeController, key, value!);
                  },
                ),
              );
            }
          }),
          SizedBox(height: size.height * 0.03),
          AddTripeButtonWidget(),
          SizedBox(height: size.width * 0.18),
        ],
      );
    });
  }
}
