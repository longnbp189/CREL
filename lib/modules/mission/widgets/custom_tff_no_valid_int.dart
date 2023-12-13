import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTFFNoValidInt extends StatefulWidget {
  const CustomTFFNoValidInt({
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
  State<CustomTFFNoValidInt> createState() => _CustomTFFNoValidIntState();
}

class _CustomTFFNoValidIntState extends State<CustomTFFNoValidInt> {
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
      cursorColor: AppColor.secondColor,
      keyboardType: widget.type,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
      ],
      controller: widget._textController,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      decoration: InputDecoration(
        labelText: widget.name,
        labelStyle: TxtStyle.heading3.copyWith(
            color: focus.hasFocus ? AppColor.primaryColor : AppColor.textColor,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColor.boderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
