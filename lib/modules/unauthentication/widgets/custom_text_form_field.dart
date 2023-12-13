import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      this.onTap,
      required this.require})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  final bool require;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _textController,
      cursorColor: AppColor.secondColor,

      style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        label: require
            ? RichText(
                text: TextSpan(
                    text: name,
                    style: TxtStyle.heading5Blue.copyWith(
                        color: AppColor.textColor, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: TxtStyle.heading5Blue.copyWith(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ]),
              )
            : Text(
                name,
                style: TxtStyle.heading5Blue.copyWith(
                    color: AppColor.textColor, fontWeight: FontWeight.bold),
              ),
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

      onTap: onTap,
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
    );
  }
}
