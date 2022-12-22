import 'package:attendence_mangement_system/Utils/Validators/validator.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Themes/Colors.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    required this.editingController,
    Key? key,
  }) : super(key: key);
  final TextEditingController editingController;
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isobscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.editingController,
        validator: ((value) {
          if (value != null && value.isEmpty) {
            return 'Please enter password';
          } else {
            if (!Validators.passwordValidates(value.toString())) {
              return 'Enter valid password';
            } else {
              return null;
            }
          }
        }),
        obscureText: _isobscure,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: primaryColor),
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: (() {
                  setState(() {
                    _isobscure = !_isobscure;
                  });
                }),
                icon:
                    Icon(_isobscure ? Icons.visibility_off : Icons.visibility)),
            prefixIcon: const Icon(Icons.lock),
            fillColor: fillColor,
            filled: true,
            hintText: 'Password',
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
