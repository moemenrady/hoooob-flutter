import 'package:flutter/material.dart';
import 'package:hoooob_app/util/images.dart';

class TripeSuccessImageWidget extends StatelessWidget {
  const TripeSuccessImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Center(
      child: Image.asset(Images.cityDriverIcon
      ,width: size.width*0.7 ,
      ),
    );
  }
}
