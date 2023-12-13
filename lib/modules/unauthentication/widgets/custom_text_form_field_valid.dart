import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldValid extends StatelessWidget {
  const CustomTextFormFieldValid(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      required this.error})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String error;
  final String name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _textController,
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        hintText: name,
        hintStyle: TxtStyle.heading3
            .copyWith(color: AppColor.textColor, fontWeight: FontWeight.normal),
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
        return value != null && value.length < 6 ? error : null;
      },
    );
  }
}
