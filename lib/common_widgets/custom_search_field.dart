import 'package:flutter/material.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/styles.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool fillColor;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  final bool isReadOnly;
  final VoidCallback onTap;
  final double? contentPadding;
  final TextInputType? type;
  const CustomSearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.fillColor = false,
    this.focusNode,
    required this.isReadOnly,
    required this.onTap,
    this.contentPadding, this.type,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: widget.type,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.isReadOnly,
            textInputAction: TextInputAction.search,
            onTap: widget.onTap,
            enabled: true,
            style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).hintColor),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).hintColor),
              filled: widget.fillColor,
              fillColor: Theme.of(context).cardColor,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical:
                      widget.contentPadding ?? Dimensions.paddingSizeDefault),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0)),
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
