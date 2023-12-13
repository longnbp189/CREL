import 'package:crel_mobile/config/app_color.dart';
import 'package:flutter/material.dart';

class PageShadow extends StatelessWidget {
  const PageShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColor.darkerBackground])),
    );
  }
}
