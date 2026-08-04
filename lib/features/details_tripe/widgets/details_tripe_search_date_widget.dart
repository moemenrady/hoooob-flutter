import 'package:flutter/material.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:intl/intl.dart';

class DetailsTripeSearchDateWidget extends StatelessWidget {
  final DetailsTripeNavigateDataModel tripeData;
  const DetailsTripeSearchDateWidget({super.key, required this.tripeData});

  @override
  Widget build(BuildContext context) {
    DateTime date;
    if (tripeData.startDate is DateTime) {
      date = tripeData.startDate as DateTime;
    } else {
      date = DateTime.parse(tripeData.startDate.toString());
    }
    String formattedDate = DateFormat(
      'd MMMM y',
    ).format(date);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          formattedDate,
          style: textBold.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ),
    );
  }
}
