import 'package:flutter/material.dart';
import 'package:hoooob_app/common_widgets/app_bar_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';

class BodyWidget extends StatefulWidget {
  final Widget body;
  final AppBarWidget? appBar;
  final double topMargin;
  final bool isProfileScreen;
  
  const BodyWidget(
      {super.key,
      required this.body,
      this.appBar,
      this.topMargin = 10,
      this.isProfileScreen = false});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.appBar ?? SizedBox.shrink(),
      Expanded(
          child: Container(
        margin: EdgeInsets.only(top: widget.topMargin),
        width: Dimensions.webMaxWidth,
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.isProfileScreen
                  ? Theme.of(context).primaryColorDark
                  : Colors.transparent,
              width: 1.5),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          color: Theme.of(context).cardColor,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          child: widget.body,
        ),
      )),
    ]);
  }
}
