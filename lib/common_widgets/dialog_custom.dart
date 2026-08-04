import 'package:flutter/material.dart';
import 'package:hoooob_app/common_widgets/button_widget.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class DialogCustom extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DialogCustom({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.17),
      child: Container(
        width: size.width * 0.01,
        height: size.height * 0.50,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Image.asset(
              image,
              width: size.width * 0.9,
            ),
            Text(
              title,
              style: textBold.copyWith(
                  color: Theme.of(context).textTheme.labelLarge!.color,
                  fontSize: 20),
            ),
            Text(
              subtitle,
              style: textMedium.copyWith(
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                  fontSize: Dimensions.fontSizeLarge),
            ),
            ButtonWidget(
              onPressed: onTap,
              buttonText: 'موافق',
              backgroundColor: Theme.of(context).primaryColor,
              width: size.width * 0.4,
              radius: 50,
            )
          ],
        ),
      ),
    );
  }
}
