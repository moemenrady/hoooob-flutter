import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hoooob_app/common_widgets/from_to_icon_widget.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/features/details_tripe/widgets/details_tripe_text_from_to_widgets.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:intl/intl.dart';

class DetailsTripeFromToWidget extends StatelessWidget {
  final DetailsTripeNavigateDataModel tripeData;
  final bool isUserTripe;

  const DetailsTripeFromToWidget({
    super.key,
    required this.tripeData,
    required this.isUserTripe,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String formattedFromTime;
    String formattedToTime;

    if (isUserTripe == false) {
      DateTime? fromTime = tripeData.startTime;
      DateTime? toTime = tripeData.startTime;
      formattedFromTime =
          fromTime != null ? DateFormat.Hm().format(fromTime) : '-';
      formattedToTime = toTime != null ? DateFormat.Hm().format(toTime) : '-';
    } else {
      formattedFromTime = tripeData.startDate;
      formattedToTime = tripeData.startTime;
    }
    return Container(
      height: size.height * 0.2,
      width: size.width * 0.90,
      padding: EdgeInsets.only(top: size.height * 0.01),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(1, 5),
          )
        ],
        color: Get.isDarkMode
            ? Theme.of(context).primaryColorDark
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DetailsTripeTextFromToWidgets(
            fromTripe: tripeData.fromAddress.toString(),
            toTripe: tripeData.toAddress.toString(),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          FromToIconWidget(
            color: Colors.transparent,
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Column(
            spacing: size.height * 0.02 + 3,
            children: [
              _defaultTextTime(
                context,
                text: '${formattedToTime}\nمساءً',
                fontWeight: FontWeight.w500,
              ),
              _defaultTextTime(
                context,
                text: '${formattedFromTime}\nمساءً',
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.08,
          ),
        ],
      ),
    );
  }

  Widget _defaultTextTime(
    BuildContext context, {
    required String text,
    required FontWeight fontWeight,
  }) {
    return Text(
      maxLines: 2,
      textAlign: TextAlign.center,
      text,
      style: textSemiBold.copyWith(
        color: Theme.of(context).primaryColorDark,
        fontSize: 12,
        fontWeight: fontWeight,
      ),
    );
  }
}
