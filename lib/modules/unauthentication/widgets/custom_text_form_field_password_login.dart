import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormFieldPasswordLogin extends StatefulWidget {
  const CustomTextFormFieldPasswordLogin(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      this.icon,
      required this.type,
      this.fun,
      this.hide = true})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  final bool? hide;
  final IconButton? icon;
  final Function()? fun;
  final TextInputType type;

  @override
  State<CustomTextFormFieldPasswordLogin> createState() =>
      _CustomTextFormFieldPasswordLoginState();
}

class _CustomTextFormFieldPasswordLoginState
    extends State<CustomTextFormFieldPasswordLogin> {
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
      keyboardType: widget.type,
      controller: widget._textController,

      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
            onPressed: widget.fun!,
            splashColor: Colors.transparent,
            icon: widget.hide!
                ? FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    color: focus.hasFocus
                        ? AppColor.primaryColor
                        : AppColor.textColor,
                  )
                // ? Icon(
                //     Icons.password,
                //     color: focus.hasFocus
                //         ? AppColor.primaryColor
                //         : AppColor.textColor,
                //   )
                : FaIcon(
                    FontAwesomeIcons.eye,
                    color: focus.hasFocus
                        ? AppColor.primaryColor
                        : AppColor.textColor,
                  )),
        labelText: widget.name,
        labelStyle: TxtStyle.heading3.copyWith(
            color: focus.hasFocus ? AppColor.primaryColor : AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColor.boderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),

          borderSide: const BorderSide(
            color: AppColor.primaryColor,
          ),
          // borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,

      validator: (value) {
        if (value == null || value.isEmpty || value.trim() == "") {
          return "${widget.name} không được để trống.";
        } else {
          return null;
        }
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
    );
  }
}
