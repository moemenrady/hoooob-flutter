import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hoooob_app/common_widgets/no_data_widget.dart';
import 'package:hoooob_app/features/home/controllers/search_tripe_controller.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_item_widget.dart';
import 'package:hoooob_app/features/search_trips/widgets/search_tripe_shimmer_effect.dart';

class SearchTripeListViewWidget extends StatelessWidget {
  const SearchTripeListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchTripeController>(builder: (searchTripeController) {
      return ValueListenableBuilder(
          valueListenable: searchTripeController.isLoadingSearchTripe,
          builder: (context, isLoading, child) {
            return isLoading
                ? SearchTripeShimmerEffect()
                : searchTripeController.searchTripeList.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchTripeController.searchTripeList.length,
                        itemBuilder: (context, index) {
                          return searchTripeController.searchTripeList.isEmpty
                              ? NoDataWidget()
                              : SearchTripeItemWidget(
                                  data: searchTripeController.searchTripeList,
                                  index: index,
                                );
                        })
                    : Center(child: Text('No Trips Found'));
          });
    });
  }
}
