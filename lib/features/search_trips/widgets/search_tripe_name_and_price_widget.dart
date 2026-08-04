import 'package:flutter/material.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class SearchTripeNameAndPriceWidget extends StatelessWidget {
  final List<SearchTripeAll> tripeData;
  final int index;

  const SearchTripeNameAndPriceWidget(
      {super.key, required this.tripeData, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text('${tripeData[index].price} جنيه',
            textDirection: TextDirection.rtl,
            style: textSemiBold.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: Dimensions.fontSizeExtraLarge,
              fontWeight: FontWeight.w700,
            )),
        Spacer(),
        Text(tripeData[index].driver!.fullName.toString(),
            style: textSemiBold.copyWith(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              fontSize: Dimensions.fontSizeSmall,
              fontWeight: FontWeight.w400,
            )),
        SizedBox(
          width: size.width * 0.02,
        ),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.01 + 2),
          child: Container(
            width: size.width * 0.07,
            height: size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(Images.userIcon))),
          ),
        ),
      ],
    );
  }
}
