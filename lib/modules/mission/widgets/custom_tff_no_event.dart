import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class CustomTFFNoEvent extends StatelessWidget {
  const CustomTFFNoEvent({
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
    //                         RichText(
    //                           text: TextSpan(
    //                               text: lable,
    //                               style: TxtStyle.heading5Blue.copyWith(
    //                                   color: AppColor.textColor,
    //                                   fontWeight: FontWeight.bold),
    //                               children: [
    //                                 TextSpan(
    //                                   text: ' *',
    //                                   style: TxtStyle.heading5Blue.copyWith(
    //                                       color: Colors.red,
    //                                       fontWeight: FontWeight.bold),
    //                                 )
    //                               ]),
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
    //                   : RichText(
    //                       text: TextSpan(
    //                           text: lable,
    //                           style: TxtStyle.heading4.copyWith(
    //                               color: AppColor.textColor,
    //                               fontWeight: FontWeight.bold),
    //                           children: [
    //                             TextSpan(
    //                               text: ' *',
    //                               style: TxtStyle.heading4.copyWith(
    //                                   color: Colors.red,
    //                                   fontWeight: FontWeight.bold),
    //                             )
    //                           ]),
    //                     ),
    //             ))));

    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.boderColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextFormField(
          controller: _textController,
          cursorColor: AppColor.secondColor,
          style: TxtStyle.heading5Blue
              .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                  text: lable,
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
                fontSize: 16,
                fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColor.boderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            errorStyle: const TextStyle(color: Colors.red),
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
