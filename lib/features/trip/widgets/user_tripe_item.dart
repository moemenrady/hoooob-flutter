import 'package:flutter/material.dart';
import 'package:hoooob_app/features/trip/domain/models/passengers_tripes_response_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:screenshot/screenshot.dart';

import '../../../common_widgets/from_to_icon_widget.dart';


class UserTripeItem extends StatelessWidget {
  final int index;
  final List<TripePassengerData> passengerTripe;

  const UserTripeItem(
      {super.key, required this.index, required this.passengerTripe});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var data = passengerTripe[index];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Container(
        // width: size.width,
        height: size.height * 0.16 ,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.01),
                  Expanded(
                    child: Row(
                      children: [
                        FromToIconWidget(
                          widthImage: size.width * 0.100,
                          heightLine: size.height * 0.03+5,
                          isLeft: true,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Column(

                            children: [
                              _defaultText(context, data.startAddress),
                              SizedBox(
                                height: size.height * 0.04+5,
                              ),
                              _defaultText(context, data.endAddress),
                            ],
                          ),
                        ),
                        SizedBox(width: size.width * 0.06),
                        SizedBox(
                          height: size.height * 0.1 + 9,
                          child: Expanded(
                            child: VerticalDivider(
                              color: Theme.of(context).primaryColor,
                              thickness: 2.1,
                              // indent: 1,
                              // endIndent: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        _dateAndTime(context, passengerTripe),
                      ],
                    ),
                  ),
                  Row(
                    spacing: size.width * 0.03,
                    children: [
                      Image.asset(
                        Images.carTripeIcon,
                        width: size.width * 0.05 - 2,
                      ),
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
                      _defaultText(context, data.driverName),
                      // SizedBox(width: size.width * 0.08,),
                      // _statTripeText (context),
                    ],
                  ),
                  SizedBox(
                      height: size.height * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateAndTime(
      BuildContext context, List<TripePassengerData> passengerTripe) {
    var size = MediaQuery.of(context).size;

    return Column(
      // spacing: size.height * 0.01 - 5,
      children: [
        Image.asset(Images.clockIcon, width: size.width * 0.05),
        _defaultText(context, passengerTripe[index].startHour),
        Image.asset(Images.calender2Icon, width: size.width * 0.05),
        _defaultText(context, passengerTripe[index].startDay),
        SizedBox(height: size.height * 0.01 ),
        Text(
          passengerTripe[index].status,
          style: textBold.copyWith(
            color: _stateColor(context, passengerTripe),
          ),
        ),
      ],
    );
  }

  Color _stateColor(
      BuildContext context, List<TripePassengerData> passengerTripe) {
    if (passengerTripe[index].status == 'pending') {
      return Theme.of(context).hintColor;
    } else if (passengerTripe[index].status == 'accept') {
      return Theme.of(context).colorScheme.primary;
    } else if (passengerTripe[index].status == 'reject') {
      return Theme.of(context).colorScheme.error;
    } else {
      return Colors.transparent;
    }
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
