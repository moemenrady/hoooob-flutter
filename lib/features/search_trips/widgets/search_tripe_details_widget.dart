import 'package:flutter/material.dart';
import 'package:hoooob_app/features/home/domain/models/search_tripe_response_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class SearchTripeDetailsWidget extends StatelessWidget {
  final List<SearchTripeAll> tripeData;
  final int index;

  const SearchTripeDetailsWidget(
      {super.key, required this.tripeData, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _defaultImageAndIcon(
          context,
          imagePath: Images.userIcon,
          name: '${tripeData[index].seatsAvailable}  مقاعد',
        textDirection: TextDirection.rtl,
        ),
        _defaultImageAndIcon(
          context,
          imagePath: Images.userIcon,
          name: tripeData[index].isAc! ? 'مكيف' : 'غير مكيف',
        ),
        _defaultImageAndIcon(
          context,
          imagePath: Images.userIcon,
          name:
          tripeData[index].isSmokingAllowed!
              ? 'مسموح بالتدخين'
              : 'غير مسموح بالتدخين',
        ),
      ],
    );
  }

  Widget _defaultImageAndIcon(BuildContext context, {
    required String name,
    required String imagePath,
     TextDirection? textDirection,
  }) {
    return Row(
      spacing: MediaQuery
          .sizeOf(context)
          .width * 0.01,
      children: [
        Text(
          textDirection:textDirection,
          name,
          style: textRegular.copyWith(
            color: Theme
                .of(context)
                .textTheme
                .bodyMedium!
                .color,
            fontSize: Dimensions.fontSizeSmall,
            fontWeight: FontWeight.w400,
          ),
        ),
        Image.asset(
          imagePath,
          width: MediaQuery
              .sizeOf(context)
              .width * 0.05,
        ),
      ],
    );
  }
}
