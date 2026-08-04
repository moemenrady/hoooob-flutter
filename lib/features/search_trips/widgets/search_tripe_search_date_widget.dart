import 'package:flutter/material.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class SearchTripeSearchDateWidget extends StatelessWidget {
  const SearchTripeSearchDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('28 مايو 2025',style:
    textBold.copyWith(
      fontSize: Dimensions.fontSizeDefault,
      color: Theme.of(context).textTheme.bodyMedium!.color,
    )
      ,);
  }
}
