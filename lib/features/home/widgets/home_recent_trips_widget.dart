import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/from_to_text_arrow_icon_widget.dart';
import 'package:hoooob_app/features/home/controllers/search_tripe_controller.dart';
import 'package:hoooob_app/features/home/domain/models/recent_search_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class HomeRecentTripsWidget extends StatefulWidget {
  const HomeRecentTripsWidget({super.key});

  @override
  State<HomeRecentTripsWidget> createState() => _HomeRecentTripsWidgetState();
}

class _HomeRecentTripsWidgetState extends State<HomeRecentTripsWidget> {
  @override
  void initState() {
    super.initState();
    // Load recent searches when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SearchTripeController>().loadRecentSearches();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<SearchTripeController>(builder: (searchController) {
      return Column(
        spacing: size.height * .03,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * .02,
          ),
          Text(
            'recent_trips'.tr,
            style: _defaultTextStyle(),
          ),
          if (searchController.recentSearches.isEmpty)
            Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Text(
                'no_recent_searches'.tr,
                style: textRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeSmall,
                ),
              ),
            )
          else
            Column(
              spacing: 18,
              children:
                  searchController.recentSearches.take(3).map((recentSearch) {
                return GestureDetector(
                  onTap: () =>
                      _onRecentSearchTap(recentSearch, searchController),
                  child: FromToTextArrowIconWidget(
                    fromLocation: recentSearch.fromLocation,
                    toLocation: recentSearch.toLocation,
                    isShowArrowButton: false,
                  ),
                );
              }).toList(),
            )
        ],
      );
    });
  }

  void _onRecentSearchTap(
      RecentSearchModel recentSearch, SearchTripeController searchController) {
    // Set the recent search data as current search
    searchController.useRecentSearch(recentSearch);

    // Navigate to search results
    searchController.getAllSearchTripe('');
  }

  TextStyle _defaultTextStyle() {
    return textRegular.copyWith(
      fontSize: Dimensions.fontSizeDefault,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }
}
