import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/util/styles.dart';

class AddTripeDetailsTextWidget extends StatelessWidget {
  const AddTripeDetailsTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
      child: Text('details_tripe'.tr,style: textRegular.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black),),
    );
  }
}
