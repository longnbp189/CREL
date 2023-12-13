import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class ChooseTextFromDrop extends StatelessWidget {
  const ChooseTextFromDrop({
    Key? key,
    // required this.name,
    required this.lable,
    required this.isDisable,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  // final String name;
  final String lable;
  final TextEditingController _textController;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
            color: isDisable ? AppColor.boderColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        // height: 50,
        child: TextFormField(
          controller: _textController,
          cursorColor: AppColor.secondColor,
          style: TxtStyle.heading5Blue.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDisable ? AppColor.boderColor : Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            label: RichText(
              text: TextSpan(
                  text: lable,
                  style: TxtStyle.heading4.copyWith(
                      color: AppColor.textColor,
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
                color: AppColor.textColor,
                // fontSize: 16,
                fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColor.boderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            errorStyle: TextStyle(color: Colors.red.shade400),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColor.primaryColor,
              ),
              // borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            return value == null || value.isEmpty || value.trim() == ""
                ? "$lable không được để trống."
                // :
                //       //  double.parse(AppFormat.savePrice(value)) < 1
                //       //     ? "${widget.name} không được bé hơn hoặc bằng 0."
                : null;
            //   // },
            //   // return value!.length < 6 ? "$name không được để trống." : null;
          },
        ),
      ),
    );
  }
}
