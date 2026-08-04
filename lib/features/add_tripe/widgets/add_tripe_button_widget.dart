import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/common_widgets/custom_snackbar.dart';
import 'package:hoooob_app/common_widgets/image_title_subtitle.dart';
import 'package:hoooob_app/common_widgets/loader_widget.dart';
import 'package:hoooob_app/features/add_tripe/controller/create_tripe_controller.dart';

class AddTripeButtonWidget extends StatefulWidget {
  const AddTripeButtonWidget({super.key});

  @override
  State<AddTripeButtonWidget> createState() => _AddTripeButtonWidgetState();
}

class _AddTripeButtonWidgetState extends State<AddTripeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<AddTripeController>(builder: (addTripeController) {
      return ValueListenableBuilder(
          valueListenable: addTripeController.isLoadingAddTripe,
          builder: (context, isLoading, child) {
            return isLoading
                ? const LoaderWidget()
                : ButtonWidget(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ImageTitleSubTitle(
                      //       title: 'مبارك!',
                      //       subTitle: 'تم انشاء رحلتك بنجاح',
                      //     ),
                      //   ),
                      // );
                      addTripeController
                          .actionThenTapButton(addTripeController);
                      print(
                          'addTripeController.startLat${addTripeController.startLat}');
                      print(addTripeController.startLng);
                      print(addTripeController.startLng);
                      print(addTripeController.endLat);
                      print(addTripeController.endLng);
                    },
                    buttonText: 'continue2'.tr,
                    width: size.width,
                    height: size.height * 0.05 + 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  );
          });
    });
  }
}
