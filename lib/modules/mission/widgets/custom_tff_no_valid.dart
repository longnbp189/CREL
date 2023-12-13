import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTFFNoValid extends StatefulWidget {
  const CustomTFFNoValid({
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
  State<CustomTFFNoValid> createState() => _CustomTFFNoValidState();
}

class _CustomTFFNoValidState extends State<CustomTFFNoValid> {
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
      controller: widget._textController,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      decoration: InputDecoration(
        labelText: widget.name,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        labelStyle: TxtStyle.heading4.copyWith(
            color: focus.hasFocus ? AppColor.primaryColor : AppColor.textColor,
            fontWeight: FontWeight.bold),
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
    );
  }
}
