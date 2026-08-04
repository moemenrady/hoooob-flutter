import 'package:flutter/material.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/features/home/screens/home_screen.dart';

class TripeSuccessButtonWidget extends StatelessWidget {
  const TripeSuccessButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      buttonText: 'موافق',
      fontSize: 20,
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => HomeScreen()),(route) => false);
      },
    );
  }
}
