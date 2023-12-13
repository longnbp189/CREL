import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTFFRequiredContentTerm extends StatefulWidget {
  const CustomTFFRequiredContentTerm({
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
  State<CustomTFFRequiredContentTerm> createState() =>
      _CustomTFFRequiredContentTermState();
}

class _CustomTFFRequiredContentTermState
    extends State<CustomTFFRequiredContentTerm> {
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
      maxLines: 5,
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      keyboardType: widget.type,
      controller: widget._textController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        floatingLabelBehavior: FloatingLabelBehavior.never,
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
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          borderSide: BorderSide(color: AppColor.boderColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          borderSide: BorderSide(
            color: AppColor.primaryColor,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),

          borderSide: BorderSide(
            color: AppColor.primaryColor,
          ),
          // borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value == null || value.isEmpty || value.trim() == ""
            ? "${widget.name} không được để trống."
            : null;
        // },
        // return value!.length < 6 ? "$name không được để trống." : null;
      },
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ' '; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    if (newValue.text.split(",").length > 2) {
      return oldValue;
    }
    var newValueText = newValue.text;
    if (oldValue.text.contains(" ") && !newValue.text.contains(" ")) {
      newValueText = newValueText.substring(1, newValueText.length);
    }
    var numbers = newValueText.replaceAll(separator, '').split(',');
    if ((numbers.length == 2 && numbers[1].length > 2) ||
        numbers[0].length > 4) {
      return oldValue;
    }

    final chars = numbers[0];
    String newString = '';
    for (int i = chars.length - 1; i >= 0; i--) {
      if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
        newString = separator + newString;
      }
      newString = chars[i] + newString;
    }

    if (numbers.length == 2) {
      newString = newString + "," + numbers[1];
    }

    if (newValueText.contains(".") || newValueText.contains("-")) {
      return oldValue;
    }

    // // Handle "deletion" of separator character
    // String oldValueText = oldValue.text.replaceAll(separator, '');
    // String newValueText = newValue.text.replaceAll(separator, '');

    // if (oldValue.text.endsWith(separator) &&
    //     oldValue.text.length == newValue.text.length + 1) {
    //   newValueText = newValueText.substring(0, newValueText.length - 1);
    // }

    // // Only process if the old value and new value are different
    // if (oldValueText != newValueText) {
    int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
    //   final chars = newValueText.split('');

    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndex,
      ),
    );
  }
}
