import 'package:flutter/material.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class FromToTextArrowIconWidget extends StatelessWidget {
  final double? width;
  final bool? isShowArrowButton;
  final String? fromLocation;
  final String? toLocation;
  const FromToTextArrowIconWidget({
    super.key,
    this.width,
    this.isShowArrowButton = true,
    this.fromLocation,
    this.toLocation,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: width ?? size.width * 0.8,
        height: size.height * .07 - 5,
        padding:
            EdgeInsets.only(left: size.width * 0.08, right: size.width * 0.04),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(1, 2),
            )
          ],
        ),
        child: Row(
          children: [
            isShowArrowButton == true
                ? Image.asset(
                    Images.arrowLeft2Icon,
                    height: size.height * 0.02,
                    width: size.width * 0.02,
                  )
                : SizedBox(),
            Spacer(),
            Text(
              _truncateToTwoWords(fromLocation ?? 'سموحة'),
              style: _defaultTextStyle(),
            ),
            SizedBox(
              width: size.width * .02,
            ),
            Image.asset(
              Images.arrowLeft1Icon,
              height: size.height * 0.06,
              width: size.width * 0.06,
            ),
            SizedBox(
              width: size.width * .01,
            ),
            Text(
              _truncateToTwoWords(toLocation ?? 'مصر الجديدة'),
              style: _defaultTextStyle(),
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            Image.asset(
              Images.clockIcon,
              height: size.height * 0.06,
              width: size.width * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _defaultTextStyle() {
    return textRegular.copyWith(
      fontSize: Dimensions.fontSizeDefault,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  String _truncateToTwoWords(String text) {
    List<String> words = text.trim().split(' ');
    if (words.length <= 2) {
      return text;
    }
    return '${words[0]} ${words[1]}';
  }
}
