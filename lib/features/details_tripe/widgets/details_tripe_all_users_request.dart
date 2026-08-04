import 'package:flutter/material.dart';
import 'package:hoooob_app/features/details_tripe/domain/models/details_tripe_navigate_data_model.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class DetailsTripeAllUsersRequest extends StatelessWidget {
  final DetailsTripeNavigateDataModel tripeData;

  const DetailsTripeAllUsersRequest({super.key, required this.tripeData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.90,
      height: size.height * 0.09,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(1, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          tripeData.passengersData!.length,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.09,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                  image: DecorationImage(
                    image: NetworkImage(
                        tripeData.passengersData![index].image.toString()),
                  ),
                ),
              ),
              Text(
                tripeData.passengersData![index].name.toString(),
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
