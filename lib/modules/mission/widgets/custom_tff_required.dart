import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTFFRequired extends StatelessWidget {
  const CustomTFFRequired(
      {Key? key,
      required TextEditingController textController,
      required this.name,
      // required this.lable,
      required this.type
      // required this.read,
      })
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String name;
  // final String lable;
  final TextInputType type;

  // final bool read;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 58,
    //   padding: const EdgeInsets.only(left: 12),
    //   decoration: BoxDecoration(
    //     border: Border.all(width: 2, color: AppColor.boderColor),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(10),
    //     ),
    //   ),
    //   child: TextFormField(
    //     controller: _textController,
    //     keyboardType: type,
    //     onFieldSubmitted: (value) {
    //       _textController.text = value;
    //     },
    //     validator: (value) {
    //       return value == null || value.isEmpty || value.trim() == ""
    //           ? "$name không được để trống."
    //           : null;
    //     },
    //     cursorColor: AppColor.secondColor,
    //     style: TxtStyle.heading5Blue.copyWith(
    //       fontWeight: FontWeight.normal,
    //       fontSize: 14,
    //     ),
    //     decoration: (_textController.text != "")
    //         ? InputDecoration(
    //             // contentPadding: const EdgeInsets.only(bottom: 0.0, top: 15.0),
    //             focusColor: AppColor.secondColor,
    //             // floatingLabelBehavior: FloatingLabelBehavior.never,

    //             labelStyle: TxtStyle.heading3.copyWith(
    //                 color: AppColor.textColor,
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.bold),

    //             // contentPadding: const EdgeInsets.only(top: 12),
    //             // floatingLabelAlignment: FloatingLabelAlignment.start,
    //             // floatingLabelBehavior: FloatingLabelBehavior.always,
    //             // errorStyle: const TextStyle(fontSize: 5, height: 0.3),
    //             label: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 RichText(
    //                   text: TextSpan(
    //                       text: name,
    //                       style: TxtStyle.heading3.copyWith(
    //                           color: AppColor.textColor,
    //                           fontSize: 14,
    //                           fontWeight: FontWeight.bold),
    //                       children: [
    //                         TextSpan(
    //                           text: ' *',
    //                           style: TxtStyle.heading3.copyWith(
    //                               color: Colors.red,
    //                               fontSize: 14,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       ]),
    //                 ),
    //                 // const SizedBox(
    //                 //   height: 5,
    //                 // )
    //               ],
    //             ),
    //             // labelText: lable,
    //             // labelStyle: TxtStyle.heading3.copyWith(
    //             //   color: AppColor.textColor,
    //             //   fontWeight: FontWeight.bold,
    //             //   height: 1,
    //             // ),
    //             border: InputBorder.none)
    //         : InputDecoration(
    //             focusColor: AppColor.secondColor,
    //             label: RichText(
    //               text: TextSpan(
    //                   text: name,
    //                   style: TxtStyle.heading4.copyWith(
    //                       color: AppColor.textColor,
    //                       fontWeight: FontWeight.bold),
    //                   children: [
    //                     TextSpan(
    //                       text: ' *',
    //                       style: TxtStyle.heading4.copyWith(
    //                           color: Colors.red, fontWeight: FontWeight.bold),
    //                     )
    //                   ]),
    //             ),
    //             border: InputBorder.none),
    //   ),
    // );
    return TextFormField(
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      keyboardType: type,
      controller: _textController,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
              text: name,
              style: TxtStyle.heading3.copyWith(
                  color: AppColor.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: ' *',
                  style: TxtStyle.heading3.copyWith(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        labelStyle: TxtStyle.heading3.copyWith(
            color: AppColor.textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.boderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      // autocorrect: true,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value == null || value.isEmpty || value.trim() == ""
            ? "$name không được để trống."
            : null;
        // },
        // return value!.length < 6 ? "$name không được để trống." : null;
      },
    );
  }
}
