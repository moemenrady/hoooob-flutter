import 'package:flutter/material.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class SearchTripeNameCarNadIconWidget extends StatelessWidget {
  final List<SearchTripeAll> tripeData;
  final int index;
  const SearchTripeNameCarNadIconWidget({super.key, required this.index, required this.tripeData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing:6.5 ,
      children: [
        Text(
          tripeData[index].category.toString(),
          style: textSemiBold.copyWith(
            color: Theme.of(context).primaryColor,

            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Image.asset(
          Images.car,
          width: size.width * 0.06,
        ),

      ],
    );
  }
}
