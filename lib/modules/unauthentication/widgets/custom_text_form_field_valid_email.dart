import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldEmail extends StatefulWidget {
  const CustomTextFormFieldEmail(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      required this.isDisable,
      required this.type})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  final TextInputType type;
  final bool isDisable;

  @override
  State<CustomTextFormFieldEmail> createState() =>
      _CustomTextFormFieldEmailState();
}

class _CustomTextFormFieldEmailState extends State<CustomTextFormFieldEmail> {
  FocusNode focus = FocusNode();

  @override
  void initState() {
    focus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bool emailValid = RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(value);
    return TextFormField(
        keyboardType: widget.type,
        focusNode: focus,
        controller: widget._textController,
        onFieldSubmitted: (value) {
          widget._textController.text = value;
        },
        cursorColor: AppColor.secondColor,
        style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.isDisable ? AppColor.boderColor : Colors.white,

          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          label: RichText(
            text: TextSpan(
                text: widget.name,
                style: TxtStyle.heading3.copyWith(
                    color: focus.hasFocus
                        ? AppColor.primaryColor
                        : AppColor.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TxtStyle.heading3.copyWith(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
          // labelText: widget.name,
          labelStyle: TxtStyle.heading3.copyWith(
              color:
                  focus.hasFocus ? AppColor.primaryColor : AppColor.boderColor,
              fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColor.boderColor),
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
          if (value == null || value.isEmpty || value.trim() == "") {
            return "${widget.name} không được để trống.";
          } else if (!AppFormat.validateEmail(value.trim())) {
            return "${widget.name} không hợp lệ.";
          } else {
            return null;
          }
        }
        // {
        // return value == null || value.isEmpty || value.trim() == ""
        //     ? "$name không được để trống."
        //     : null;\
        // return EmailValidator.validate(value!) ? "ádasdasdsa" : null;
        // },
        );
  }
}
