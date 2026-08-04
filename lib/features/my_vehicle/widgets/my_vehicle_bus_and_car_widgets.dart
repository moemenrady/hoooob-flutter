import 'package:flutter/material.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class MyVehicleBusAndCarWidgets extends StatefulWidget {
  const MyVehicleBusAndCarWidgets({super.key});

  @override
  State<MyVehicleBusAndCarWidgets> createState() =>
      _MyVehicleBusAndCarWidgetsState();
}

List<String> _icon = [
  Images.car2Icon,
  Images.busIcon,
];
List<String> _name = [
  'تويوتا كورولا ',
  'جو باص',
];

class _MyVehicleBusAndCarWidgetsState extends State<MyVehicleBusAndCarWidgets> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(_icon.length, (index) {
        return Container(
          width: size.width,
          height: size.height * .07,
          margin: EdgeInsets.symmetric(vertical: size.height * .01),
          padding: EdgeInsets.symmetric(horizontal: size.width * .03),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(1, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                _icon[index],
                width: size.width * .06,
              ),
              SizedBox(width: size.width * .03),
              Text(
                _name[index],
                style: textBold.copyWith(
                    color: Theme.of(context).textTheme.labelLarge!.color),
              ),
              Spacer(),
              Image.asset(
                Images.trashIcon,
                width: size.width * .06,
              ),
            ],
          ),
        );
      }),
    );
  }
}
