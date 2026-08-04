import 'package:flutter/material.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class TripeSuccessTextWidget extends StatelessWidget {
  const TripeSuccessTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textDirection: TextDirection.rtl,
          'تم ارسال طلب حجز الرحلة!',
          style: textBold.copyWith(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 20),
        ),
        Text(
          textAlign: TextAlign.center,
          'تم ارسال طلب حجز الرحلة الي السائق وفي\n انتظار رده',
          style: textMedium.copyWith(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 16),
        ),
      ],
    );
  }
}
