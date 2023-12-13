import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTFFRequiredM extends StatefulWidget {
  const CustomTFFRequiredM(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      // required this.lable,
      required this.type,
      required this.isM,
      required this.isDisable
      // required this.read,
      })
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  final int isM;
  final bool isDisable;
  // final String lable;
  final TextInputType type;

  @override
  State<CustomTFFRequiredM> createState() => _CustomTFFRequiredMState();
}

class _CustomTFFRequiredMState extends State<CustomTFFRequiredM> {
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
    return widget.isDisable
        ? ChooseTextFromDrop(
            isDisable: widget.isDisable,
            lable: widget.name,
            textController: widget._textController)
        : TextFormField(
            focusNode: focus,
            inputFormatters: (widget.isM == 0)
                ? [
                    // FilteringTextInputFormatter.allow(
                    //     RegExp(r'^\d{1,2}\,?\d{0,2}')),
                    MeterSeparatorInputFormatter()

                    // LengthLimitingTextInputFormatter(2),
                    // MeterFormatter()
                    // CurrencyInputFormatter(),
                  ]
                : (widget.isM == 1)
                    ? [
                        // FilteringTextInputFormatter.allow(
                        // RegExp(r'^\d{0,4}\,?\d{0,2}')),

                        MeterSquareSeparatorInputFormatter()
                        // FilteringTextInputFormatter.allow(
                        //     RegExp(r'(^\d*\.?\d{0,2})')),
                        // LengthLimitingTextInputFormatter(2),
                      ]
                    : (widget.isM == 3)
                        ? [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ]
                        : [FilteringTextInputFormatter.singleLineFormatter],
            cursorColor: AppColor.secondColor,
            style: TxtStyle.heading5Blue
                .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
            keyboardType: widget.type,
            controller: widget._textController,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.isDisable ? AppColor.boderColor : Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              suffix: Text(
                widget.isM == 0
                    ? "m"
                    : widget.isM == 1
                        ? "m\u00B2"
                        : "",
                style: TxtStyle.heading4.copyWith(
                    color: focus.hasFocus
                        ? AppColor.primaryColor
                        : AppColor.textColor),
              ),
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
                  color: focus.hasFocus
                      ? AppColor.primaryColor
                      : AppColor.textColor,
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

class MeterSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ' '; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    if (newValue.text[0] == ',' ||
        newValue.text.split(",").length > 2 ||
        newValue.text.contains(".") ||
        newValue.text.contains("-") ||
        newValue.text.contains(" ")) {
      return oldValue;
    }
    var newValueText = newValue.text;
    // if (oldValue.text.contains(" ") && !newValue.text.contains(" ")) {
    //   newValueText = newValueText.substring(1, newValueText.length);
    // }
    var numbers = newValueText.split(',');
    if ((numbers.length == 2 && numbers[1].length > 2) ||
        numbers[0].length > 2 ||
        int.tryParse(numbers[0]) == 0) {
      return oldValue;
    }
    int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
    return TextEditingValue(
      text: newValueText.toString(),
      selection: TextSelection.collapsed(
        offset: newValueText.length - selectionIndex,
      ),
    );
  }
}

class MeterSquareSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ' '; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    if (newValue.text[0] == ',' ||
        newValue.text.split(",").length > 2 ||
        newValue.text.contains(".") ||
        newValue.text.contains("-") ||
        newValue.text.contains(" ")) {
      return oldValue;
    }
    var newValueText = newValue.text;
    // if (oldValue.text.contains(" ") && !newValue.text.contains(" ")) {
    //   newValueText = newValueText.substring(1, newValueText.length);
    // }
    var numbers = newValueText.split(',');
    if ((numbers.length == 2 && numbers[1].length > 2) ||
        numbers[0].length > 4 ||
        int.tryParse(numbers[0]) == 0) {
      return oldValue;
    }
    int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
    return TextEditingValue(
      text: newValueText.toString(),
      selection: TextSelection.collapsed(
        offset: newValueText.length - selectionIndex,
      ),
    );
  }
}
