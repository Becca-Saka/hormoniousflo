import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';


class AppInput extends StatelessWidget {
  final TextInputType textInputType;
  final bool enabled;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const AppInput({
    Key? key,
    this.textInputType = TextInputType.name,
    this.enabled = true,
    required this.hintText,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        minLines: null,
        maxLines: null,
        expands: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        enabled: enabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
              color: Colors.grey[400],
              fontSize: 15),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(
              color: kBlueColour,
              width: 1.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(
              color: kBlueColour,
              width: 1.8,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(
              color: kBlueColour,
              width: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}
