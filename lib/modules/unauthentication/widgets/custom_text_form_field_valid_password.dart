import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldValidPassword extends StatefulWidget {
  const CustomTextFormFieldValidPassword(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      required this.error,
      this.icon,
      this.fun,
      this.hide = true})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String error;
  final String name;
  final bool? hide;
  final IconButton? icon;
  final Function()? fun;

  @override
  State<CustomTextFormFieldValidPassword> createState() =>
      _CustomTextFormFieldValidPasswordState();
}

class _CustomTextFormFieldValidPasswordState
    extends State<CustomTextFormFieldValidPassword> {
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
    return TextFormField(
      focusNode: focus,
      obscureText: widget.hide!,
      keyboardType: TextInputType.emailAddress,
      controller: widget._textController,
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: widget.fun!,
            icon: widget.hide!
                ? Icon(
                    Icons.password,
                    color: focus.hasFocus
                        ? AppColor.primaryColor
                        : AppColor.textColor,
                  )
                : const Icon(
                    Icons.ac_unit,
                  )),
        hintText: widget.name,
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
        return value != null && value.length < 6 ? widget.error : null;
      },
    );
  }
}
