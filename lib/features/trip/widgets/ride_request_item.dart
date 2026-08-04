import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/common_widgets/from_to_icon_widget.dart';
import 'package:hoooob_app/common_widgets/loader_widget.dart';
import 'package:hoooob_app/features/details_tripe/controller/details_tripe_controller.dart';
import 'package:hoooob_app/features/details_tripe/screens/details_trips_screen.dart';
import 'package:hoooob_app/features/trip/domain/models/driver_tripes_response_model.dart';
import 'package:hoooob_app/features/trip/screens/tripe_passengers_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class RideRequestItem extends StatelessWidget {
  final List<Passenger> passenger;
  final int index;

  const RideRequestItem(
      {super.key, required this.passenger, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        // width: size.width,
        height: size.height * 0.23,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withValues(alpha: 0.1),
              blurRadius: 25,
              spreadRadius: 1,
              offset: const Offset(1, 5),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.00),
                  Row(
                    children: [
                      FromToIconWidget(
                        widthImage: size.width * 0.100,
                        heightLine: size.height * 0.03,
                        isLeft: true,
                        color: Theme.of(context).primaryColor,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _defaultText(
                                context, passenger[index].pickupAddress),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            _defaultText(
                                context, passenger[index].dropoffAddress),
                          ],
                        ),
                      ),
                      SizedBox(width: size.width * 0.16),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: size.height * 0.1 - 7,
                          child: Expanded(
                            child: VerticalDivider(
                              color: Theme.of(context).primaryColor,
                              thickness: 2.1,
                              // indent: 1,
                              // endIndent: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      _priceAndSeat(context, passenger, index),
                    ],
                  ),
                  Row(
                    spacing: size.width * 0.04,
                    children: [
                      Container(
                        width: size.width * 0.08,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(Images.userIcon),
                              fit: BoxFit.cover),
                        ),
                      ),
                      _defaultText(
                        context,
                        passenger[index].name,
                      ),
                      // SizedBox(width: size.width * 0.08,),
                      // _statTripeText(context),
                    ],
                  ),
                  Row(
                    spacing: size.width * 0.04,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: Get.find<DetailsTripeController>()
                            .isLoadingAcceptTripe,
                        builder: (context, isLoading, child) {
                          return isLoading
                              ? SizedBox(
                                  height: 15,
                                  child: LoaderWidget(),
                                )
                              : _defaultButton(context,
                                  text: "accept".tr,
                                  color: Theme.of(context).colorScheme.primary,
                                  onTap: () {
                                  Get.find<DetailsTripeController>()
                                      .cancelAndAcceptTripe(
                                          passengerId:
                                              passenger[index].passengerId,
                                          stateTripe: 'accept');
                                });
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: Get.find<DetailsTripeController>()
                            .isLoadingCancelTripe,
                        builder: (context, isLoading, child) {
                          return isLoading
                              ? SizedBox(
                            height: 15,
                            child: LoaderWidget(),
                          )
                              :   _defaultButton(context,
                              text: "reject_trip".tr,
                              color: Theme.of(context).colorScheme.error,
                              onTap: () {
                                Get.find<DetailsTripeController>().cancelAndAcceptTripe(
                                    passengerId: passenger[index].passengerId,
                                    stateTripe: 'reject');
                              });
                        },
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultButton(
    BuildContext context, {
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    var size = MediaQuery.of(context).size;

    return ButtonWidget(
        buttonText: text,
        radius: 50,
        width: size.width * 0.35,
        height: size.height * 0.04,
        backgroundColor: color,
        onPressed: onTap);
  }

  Widget _priceAndSeat(
      BuildContext context, List<Passenger> passenger, int index) {
    var size = MediaQuery.of(context).size;

    return Column(
      spacing: size.height * 0.01 - 3,
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),
        Image.asset(Images.user1Icon, width: size.width * 0.05),
        _defaultText(context, '${passenger[index].seatsCount} مقعد'),
        Image.asset(Images.coinIcon, width: size.width * 0.05),
        _defaultText(context, '${passenger[index].fare} جنيه'),
      ],
    );
  }

  Widget _defaultText(BuildContext context, String text, {Color? color}) {
    return Text(
      // textDirection: TextDirection.ltr,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text,
      style: textBold.copyWith(
        color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
        fontSize: Dimensions.fontSizeDefault,
      ),
    );
  }
}
