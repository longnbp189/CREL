import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';

class ButtonGray extends StatelessWidget {
  final String? title;
  const ButtonGray({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade400),
      child: Center(
          child: Text(
        title.toString(),
        style: TxtStyle.heading3.copyWith(color: Colors.amber),
      )),
    );
  }
}
