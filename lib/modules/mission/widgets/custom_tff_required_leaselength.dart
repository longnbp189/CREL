import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTFFRequiredLeaseLenght extends StatefulWidget {
  const CustomTFFRequiredLeaseLenght({
    Key? key,
    required TextEditingController textController,
    required this.name,
    // required this.lable,
    required this.type,
    // required this.read,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  // final String lable;
  final TextInputType type;

  @override
  State<CustomTFFRequiredLeaseLenght> createState() =>
      _CustomTFFRequiredLeaseLenghtState();
}

class _CustomTFFRequiredLeaseLenghtState
    extends State<CustomTFFRequiredLeaseLenght> {
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
        FilteringTextInputFormatter.allow(RegExp(r'^\d{1,2}\,?\d{0,1}')),
        LengthLimitingTextInputFormatter(4),
        // MeterFormatter()
        // CurrencyInputFormatter(),
      ],
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      keyboardType: widget.type,
      controller: widget._textController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        suffix: Text(
          "Năm",
          style: TxtStyle.heading4.copyWith(
              color:
                  focus.hasFocus ? AppColor.primaryColor : AppColor.textColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        label: RichText(
          text: TextSpan(
              text: widget.name,
              style: TxtStyle.heading4.copyWith(
                  color: focus.hasFocus
                      ? AppColor.primaryColor
                      : AppColor.textColor,
                  // fontSize: 16,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: ' *',
                  style: TxtStyle.heading4.copyWith(
                      color: Colors.red,
                      // fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        labelStyle: TxtStyle.heading4.copyWith(
            color: focus.hasFocus ? AppColor.primaryColor : AppColor.textColor,
            // fontSize: 16,
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
        if (value!.contains(",")) {
          value.split(",");
          return value.isEmpty || value.trim() == ""
              ? "${widget.name} không được để trống."
              : int.parse(value[0]) < 1 || int.parse(value[0]) > 15
                  ? "${widget.name} phải từ 01 đến 15 năm."
                  : null;
        } else {
          return value.isEmpty || value.trim() == ""
              ? "${widget.name} không được để trống."
              : int.parse(value) < 1 || int.parse(value) > 15
                  ? "${widget.name} phải từ 01 đến 15 năm."
                  : null;
        }

        // },
        // return value!.length < 6 ? "$name không được để trống." : null;
      },
    );
  }
}
