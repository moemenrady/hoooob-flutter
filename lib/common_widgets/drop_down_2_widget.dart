import 'package:flutter/material.dart';
import 'package:hoooob_app/util/images.dart';

class DropDown2Widget extends StatelessWidget {
  final List list;
  final void Function(String?)? onChanged;
  final Color borderColor;
  final Color? fillColor;
  final Color? dropdownColor;
  final double? borderWidth;
  final double? width;
  final double? height;
  final String? pathImage;
  final Color? textColor;

  const DropDown2Widget(
      {super.key,
      required this.list,
      this.onChanged,
      required this.borderColor,
      this.fillColor,
      this.dropdownColor,
      this.borderWidth,
      this.width,
      this.height,
      this.pathImage,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        child: DropdownButtonFormField<String>(
          value: list.first,
          icon: Image.asset(
            pathImage ?? Images.arrowDownIcon,
          ),
          decoration: InputDecoration(
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
              filled: true,
              fillColor: fillColor ?? Colors.white),
          dropdownColor: dropdownColor ?? Colors.grey,
          isExpanded: true,
          items: list.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).hintColor,
                  ),
                ));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: borderColor, width: borderWidth ?? 0.6),
    );
  }
}
