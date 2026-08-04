import 'package:flutter/widgets.dart';
import 'package:hoooob_app/util/images.dart';

class ArrowDownIcon extends StatelessWidget {
  const ArrowDownIcon({super.key});

  @override
  Widget build(BuildContext context) {
       return Image.asset(Images.arrowDownIcon,
        width: MediaQuery.of(context).size.width * 0.06
    );
  }
}
