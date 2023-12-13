import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTFFUpdateValidEmpty extends StatelessWidget {
  const CustomTFFUpdateValidEmpty(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      required this.type})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  // final String error;
  final String name;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: _textController,

      onFieldSubmitted: (value) {
        _textController.text = value;
      },
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),

      decoration: InputDecoration(
        // hintText: name,
        label: RichText(
          text: TextSpan(
              text: name,
              style: TxtStyle.heading3.copyWith(
                  color: AppColor.textColor, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: ' *',
                  style: TxtStyle.heading3
                      .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        // labelText: name,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintStyle: TxtStyle.heading3
        //     .copyWith(color: AppColor.textColor, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value == null || value.isEmpty || value.trim() == ""
            ? "$name không được để trống."
            : null;
      },
    );
  }
}
