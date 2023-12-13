import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTFFRequiredPhone extends StatefulWidget {
  const CustomTFFRequiredPhone(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      // required this.lable,
      required this.type,
      required this.isDisable
      // required this.read,
      })
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  // final String lable;
  final TextInputType type;
  final bool isDisable;

  @override
  State<CustomTFFRequiredPhone> createState() => _CustomTFFRequiredPhoneState();
}

class _CustomTFFRequiredPhoneState extends State<CustomTFFRequiredPhone> {
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
        // FilteringTextInputFormatter.digitsOnly,
        // MaskedInputFormatter('### ### ####'),
        // LengthLimitingTextInputFormatter(10),

        PhoneSeparatorInputFormatter(),

        // CurrencyInputFormatter(),
      ],
      cursorColor: AppColor.secondColor,

      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      keyboardType: widget.type,
      controller: widget._textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.isDisable ? AppColor.boderColor : Colors.white,
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
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.boderColor),
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
      // onEditingComplete: () {
      //   AppFormat.priceFormat(double.parse(widget._textController.text));
      // },

      // autocorrect: true,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value == null || value.isEmpty || value.trim() == ""
            ? "${widget.name} không được để trống."
            // :
            //  value.length != 10
            //     ? "${widget.name} phải là 10 số."
            : value[0] != "0"
                ? "${widget.name} phải bắt đầu từ số 0."
                : value.length != 12
                    ? "${widget.name} phải là 10 số."
                    : null;
        // },
        // return value!.length < 6 ? "$name không được để trống." : null;
      },
    );
  }
}

class PhoneSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ' '; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    var newValueText = newValue.text;
    var oldValueText = oldValue.text;
    if (newValueText.length > 12) {
      return oldValue;
    }
    if (newValueText.contains(".") ||
        newValueText.contains("-") ||
        newValueText.contains(",")) {
      return oldValue;
    }
    int deleteSpace = 0;
    if (oldValueText.length > newValueText.length &&
        newValueText.length >= 8 &&
        newValueText[7] != ' ' &&
        newValueText.split(' ').length < 3) {
      newValueText = newValueText.substring(0, 6) + newValueText.substring(7);
      deleteSpace = 2;
    }
    if (oldValueText.length > newValueText.length &&
        newValueText.length >= 4 &&
        newValueText[3] != ' ' &&
        newValueText.split(' ').length < 2) {
      newValueText = newValueText.substring(0, 2) + newValueText.substring(3);
      if (newValueText.length > 7) {
        deleteSpace = 3;
      } else {
        deleteSpace = 2;
      }
    }
    var numbers = newValueText.replaceAll(' ', '');
    String newString = '';
    for (int i = numbers.length - 1; i >= 0; i--) {
      if ((i == 2 || i == 5) && i != numbers.length - 1) {
        newString = ' ' + newString;
      }
      newString = numbers[i] + newString;
    }
    int selectionIndex =
        newValueText.length - newValue.selection.extentOffset + deleteSpace;
    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndex,
      ),
    );
  }
}
