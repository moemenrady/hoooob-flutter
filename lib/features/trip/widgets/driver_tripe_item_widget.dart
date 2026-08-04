import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/from_to_icon_widget.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/details_tripe/screens/details_trips_screen.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';
import 'package:hoooob_app/features/trip/controllers/trip_controller.dart';
import 'package:hoooob_app/features/trip/screens/trip_map_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class DriverTripeItemWidget extends StatelessWidget {
  final List<DriverTrip> driverTripData;
  final int index;
  final TripeController? tripController;

  const DriverTripeItemWidget(
      {super.key,
      required this.driverTripData,
      required this.index,
      this.tripController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        var tripe = driverTripData[index];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsTripScreen(
              tripeData: DetailsTripeNavigateDataModel(
                passengersData: tripe.passengers,
                fromAddress: tripe.startAddress,
                toAddress: tripe.endAddress,
                startDate: tripe.startDay,
                startTime: tripe.startHour,
                requests: tripe.passengersCount,
                // price not handel api
                price: 0,
                carName: tripe.vehicleName,
                seatsAvailable: tripe.seats,
                isSmoking: tripe.isSmokingAllowed,
                isAc: tripe.isAc,
                isMusic: tripe.hasMusic,
                isBages: tripe.allowLuggage,
                mainAge: tripe.allowedAgeMin,
                maxAge: tripe.allowedAgeMax,
                routeId: tripe.routeId,
                startLat: tripe.startCoordinates?.isNotEmpty == true
                    ? tripe.startCoordinates![0]
                    : 0.0,
                startLng: tripe.startCoordinates?.isNotEmpty == true
                    ? tripe.startCoordinates![1]
                    : 0.0,
                endLat: tripe.endCoordinates?.isNotEmpty == true
                    ? tripe.endCoordinates![0]
                    : 0.0,
                endLng: tripe.endCoordinates?.isNotEmpty == true
                    ? tripe.endCoordinates![1]
                    : 0.0,
                driverName: tripe.name,
                pickupMatchLat: tripe.startCoordinates?.isNotEmpty == true
                    ? tripe.startCoordinates![0]
                    : null,
                pickupMatchLng: tripe.startCoordinates?.isNotEmpty == true
                    ? tripe.startCoordinates![1]
                    : null,
                pickupMatchAddress: tripe.startAddress,
              ),
              isUserTrip: true,
            ),
          ),
        );
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: size.width,
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.14,
                    maxHeight: size.height * 0.16,
                  ),
                  padding: EdgeInsets.all(size.width * 0.03),
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).hintColor.withValues(alpha: 0.2),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(1, 5),
                      )
                    ],
                    color: Get.isDarkMode
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      // Left side - Route info
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // From/To addresses
                            Row(
                              children: [
                                FromToIconWidget(
                                  widthImage: size.width * 0.08,
                                  heightImage: size.height * 0.015,
                                  heightLine: size.height * 0.025,
                                  isLeft: true,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: size.width * 0.02),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _defaultText(
                                        context,
                                        driverTripData[index].startAddress,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      _defaultText(
                                        context,
                                        driverTripData[index].endAddress,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            // Vehicle info
                            Row(
                              children: [
                                Image.asset(
                                  Images.carTripeIcon,
                                  width: size.width * 0.04,
                                ),
                                SizedBox(width: size.width * 0.02),
                                Expanded(
                                  child: _defaultText(
                                    context,
                                    driverTripData[index].vehicleName,
                                    color: Theme.of(context).primaryColor,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        width: 1,
                        height: size.height * 0.08,
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      ),
                      // Right side - Time and date
                      Expanded(
                        flex: 1,
                        child: _dateAndTime(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: size.width * 0.02,
                      left: size.width * 0.02,
                      top: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        radius: size.width * 0.03 - 2,
                        child: Center(
                          child: Text(
                            driverTripData[index].passengersCount.toString(),
                            style: textBold.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        )),
                  ),
                )
              ],
            ),

            // Trip Management Buttons
            if (tripController != null) _buildTripActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTripActionButtons(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final trip = driverTripData[index];
    final tripStatus = tripController!.getTripStatus(trip);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
      child: Row(
        children: [
          // Start Trip Button for Pending Trips
          if (tripStatus == 'pending') ...[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: tripController!.isTripBeingStarted(trip.routeId)
                    ? null
                    : () => tripController!.startTrip(trip.routeId),
                icon: tripController!.isTripBeingStarted(trip.routeId)
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(Icons.play_arrow, color: Colors.white),
                label: Text(
                  tripController!.isTripBeingStarted(trip.routeId)
                      ? 'starting_trip'.tr
                      : 'start_trip'.tr,
                  style: textMedium.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                  ),
                ),
              ),
            ),
          ],

          // Action Buttons for Ongoing Trips
          if (tripStatus == 'ongoing') ...[
            // Open Map Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _openTripMap(context, trip),
                icon: Icon(Icons.map, color: Colors.white),
                label: Text(
                  'show_map'.tr,
                  style: textMedium.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.02),
            // End Trip Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: tripController!.isTripBeingEnded(trip.routeId)
                    ? null
                    : () => _showEndTripConfirmationDialog(context, trip),
                icon: tripController!.isTripBeingEnded(trip.routeId)
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(Icons.stop, color: Colors.white),
                label: Text(
                  tripController!.isTripBeingEnded(trip.routeId)
                      ? 'ending_trip'.tr
                      : 'end_trip'.tr,
                  style: textMedium.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                  ),
                ),
              ),
            ),
          ],

          // Status Badge
          if (tripStatus != 'pending' && tripStatus != 'ongoing') ...[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                decoration: BoxDecoration(
                  color: tripController!
                      .getTripStatusColor(tripStatus)
                      .withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeSmall),
                  border: Border.all(
                    color: tripController!.getTripStatusColor(tripStatus),
                  ),
                ),
                child: Text(
                  tripController!.getTripStatusDisplayText(tripStatus),
                  style: textMedium.copyWith(
                    color: tripController!.getTripStatusColor(tripStatus),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showEndTripConfirmationDialog(BuildContext context, DriverTrip trip) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.orange,
                size: 24,
              ),
              SizedBox(width: Dimensions.paddingSizeSmall),
              Text(
                'end_trip'.tr,
                style: textBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'are_you_sure_end_trip'.tr,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall),
              Text(
                'Trip ID: #${trip.routeId}',
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall),
              Text(
                'this_action_cannot_be_undone'.tr,
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'cancel'.tr,
                style: textMedium.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                tripController!.endTrip(trip.routeId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'end_trip'.tr,
                style: textMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dateAndTime(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.clockIcon, width: size.width * 0.04),
            SizedBox(width: size.width * 0.01),
            Flexible(
              child: _defaultText(
                context,
                driverTripData[index].startHour,
                maxLines: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.005),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.calender2Icon, width: size.width * 0.04),
            SizedBox(width: size.width * 0.01),
            Flexible(
              child: _defaultText(
                context,
                driverTripData[index].startDay,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _defaultText(BuildContext context, String text,
      {Color? color, int maxLines = 2}) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.ltr,
      style: textBold.copyWith(
        color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
        fontSize: Dimensions.fontSizeDefault,
      ),
    );
  }

  /// Open trip map screen with your map theme
  void _openTripMap(BuildContext context, DriverTrip trip) {
    // Navigate to trip map screen using your map theme
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TripMapScreen(trip: trip),
      ),
    );
  }
}
