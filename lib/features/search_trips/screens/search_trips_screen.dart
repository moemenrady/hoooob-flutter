import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/common_widgets/body_widget.dart';
import 'package:hoooob_app/common_widgets/choose_widget.dart';
import 'package:hoooob_app/common_widgets/from_to_text_arrow_icon_widget.dart';
import 'package:hoooob_app/features/home/controllers/search_tripe_controller.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_list_view_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';

import 'package:hoooob_app/features/search_trips/widgets/search_tripe_details_text_widgets.dart';

class SearchTripsScreen extends StatefulWidget {
  const SearchTripsScreen({super.key});

  @override
  State<SearchTripsScreen> createState() => _SearchTripsScreenState();
}

class _SearchTripsScreenState extends State<SearchTripsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SearchTripeController>().getAllSearchTripe('');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<SearchTripeController>(builder: (searchTripeController) {
        return Stack(
          children: [
            // Container(
            //   height: 160,
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).primaryColor,
            //     borderRadius: const BorderRadius.only(
            //       bottomLeft: Radius.circular(30),
            //       bottomRight: Radius.circular(30),
            //     ),
            //   ),
            // ),

            BodyWidget(
              appBar: AppBarWidget(
                title: '',
                showBackButton: false,
                height: 150,
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    18,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SearchTripeDetailsTextWidgets(),
                      SizedBox(height: size.height * 0.02),
                      FromToTextArrowIconWidget(
                        width: size.width,
                        isShowArrowButton: false,
                        fromLocation: searchTripeController.startAddress,
                        toLocation: searchTripeController.endAddress,
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChooseWidget(
                        nameList: Get.find<SearchTripeController>().select,
                        onTap: (index) {
                          final controller = Get.find<SearchTripeController>();
                          if (index != 0) {
                            controller
                                .getAllSearchTripe(controller.select[index]);
                          } else {
                            controller.getAllSearchTripe('');
                          }
                        },
                      ),
                      Expanded(child: SearchTripeListViewWidget()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
