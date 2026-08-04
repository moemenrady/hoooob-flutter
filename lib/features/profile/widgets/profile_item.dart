import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/util/animation_helper.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;
  final bool divider;
  final Color? colorImage;

  const ProfileMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.divider = true,
      this.colorImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.radiusMedium)),
            border: Border.all(
              color: Theme.of(context).hintColor.withOpacity(.4),
              width: 1,
            )),
        child: Row(children: [
          Expanded(
            child: SizedBox(
                child: ListTile(
              leading: Image.asset(
                icon,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                // color:colorImage?? Theme.of(context).primaryColor,
              ),
              title: Text(
                title.tr,
                style: textMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color!),
              ),
              onTap: onTap,
            )),
          ),
          AnimationHelper.fadeIn(
              delay: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeDefault),
                child: SvgPicture.asset(
                  Images.rightArrow2Svg,
                ),
              ))
        ]),
      ),
    );
  }
}
