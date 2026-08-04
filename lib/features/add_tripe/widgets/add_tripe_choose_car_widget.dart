import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';
import 'package:image_picker/image_picker.dart';

class AddTripeChooseCarWidget extends StatefulWidget {
  const AddTripeChooseCarWidget({super.key});

  @override
  State<AddTripeChooseCarWidget> createState() =>
      _AddTripeChooseCarWidgetState();
}

File? _image;

class _AddTripeChooseCarWidgetState extends State<AddTripeChooseCarWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        _pickImage();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        height: size.height * 0.06,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).hintColor, width: 0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              'choose car',
              style: textRegular.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
            Spacer(),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Theme.of(context).cardColor
                    : Theme.of(context).primaryColorDark.withOpacity(.50),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              child: Icon(Icons.add, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
}
