import 'package:flutter/material.dart';

import '../../../Utils/Themes/Colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.iconData,
    this.type = TextInputType.text,
    Key? key,
    required this.hint,
    required this.validator,
    required this.textEditingController,
  }) : super(key: key);
  final String hint;
  final TextInputType type;
  final String? Function(String? value) validator;
  final TextEditingController textEditingController;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: type,
        validator: validator,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: primaryColor),
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            prefixIcon: Icon(iconData),
            hintText: hint,
            hintStyle:
                Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
