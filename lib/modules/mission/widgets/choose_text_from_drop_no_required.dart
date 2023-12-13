import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class ChooseTextFromDropNoRequired extends StatelessWidget {
  const ChooseTextFromDropNoRequired({
    Key? key,
    // required this.name,
    required this.lable,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  // final String name;
  final String lable;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    // return ContainerBoder(
    //     boder: 10,
    //     width: 2,
    //     colorWidth: AppColor.boderColor,
    //     child: SizedBox(
    //         height: 60,
    //         width: AppFormat.width(context),
    //         child: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 12),
    //               child: (name != lable)
    //                   ? Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           lable,
    //                           style: TxtStyle.heading5Blue.copyWith(
    //                               color: AppColor.textColor,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                         const SizedBox(
    //                           height: 2,
    //                         ),
    //                         Text(
    //                           name.trim(),
    //                           style: TxtStyle.heading5Gray.copyWith(
    //                               fontSize: 14, color: AppColor.secondColor),
    //                         ),
    //                       ],
    //                     )
    //                   : Text(
    //                       lable,
    //                       style: TxtStyle.heading5Blue.copyWith(
    //                           color: AppColor.textColor,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //             ))));

    return TextFormField(
      enabled: false,
      controller: _textController,
      cursorColor: AppColor.secondColor,
      style: TxtStyle.heading5Blue
          .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.boderColor),
        ),
        labelText: lable,
        labelStyle: TxtStyle.heading3.copyWith(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
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
