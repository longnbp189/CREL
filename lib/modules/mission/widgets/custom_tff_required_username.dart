import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTFFRequiredUsername extends StatefulWidget {
  const CustomTFFRequiredUsername({
    Key? key,
    required TextEditingController textController,
    required this.name,
    required this.type,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  final TextInputType type;

  @override
  State<CustomTFFRequiredUsername> createState() =>
      _CustomTFFRequiredUsernameState();
}

class _CustomTFFRequiredUsernameState extends State<CustomTFFRequiredUsername> {
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
      inputFormatters: [
        //số tài khoản
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      cursorColor: AppColor.secondColor,
      keyboardType: widget.type,
      controller: widget._textController,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      decoration: InputDecoration(
        labelText: widget.name,
        labelStyle: TxtStyle.heading3.copyWith(
            color: focus.hasFocus ? AppColor.primaryColor : AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColor.boderColor),
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
        return value == null || value.isEmpty || value.trim() == ""
            ? "${widget.name} không được để trống."
            : value.trim().length < 3
                ? "${widget.name} phải từ 3 kí tự trở lên."
                : null;
        // },
        // return value!.length < 6 ? "$name không được để trống." : null;
      },
    );
  }
}
