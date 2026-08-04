import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoooob_app/features/location/widget/search_station_shimmer.dart';
import 'package:hoooob_app/features/station_points/domain/models/station_point_model.dart';
import 'package:hoooob_app/util/animation_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/features/location/controllers/location_controller.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  final LocationType type;
  const LocationSearchDialog(
      {super.key, required this.mapController, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        alignment: Alignment.topCenter,
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
          child: SizedBox(
              width: Get.width,
              child: TypeAheadField<StationPointModel>(
                suggestionsCallback: (pattern) async {
                  return await Get.find<LocationController>()
                      .searchStartPoints(pattern);
                },
                loadingBuilder: (context) {
                  return const SearchStationShimmer();
                },
                emptyBuilder: (context) {
                  return Text('');
                },
                itemBuilder: (context, StationPointModel suggestion) {
                  int index = Get.find<LocationController>()
                      .searchResults
                      .indexOf(suggestion);

                  return AnimationHelper.cardAnimation(
                    index: index,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF7F7FC),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeThree,
                        vertical: Dimensions.paddingSizeSmall,
                      ),
                      margin: const EdgeInsets.only(
                          top: 8, left: 10, right: 10, bottom: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/location.svg',
                            height: 22,
                            width: 22,
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Expanded(
                            child: Text(
                              suggestion.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Cairo',
                                color: Color(0xFF000000),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                onSelected: (StationPointModel suggestion) async {
                  final controller = Get.find<LocationController>();

                  controller.onSearchResultTap(suggestion);

                  await controller.moveCameraToPoint(suggestion);

                  Get.back();
                },
              )),
        ),
      ),
    );
  }
}
