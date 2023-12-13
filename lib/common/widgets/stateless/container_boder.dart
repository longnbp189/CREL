import 'package:flutter/material.dart';

class ContainerBoder extends StatelessWidget {
  final double? boder;
  final double? width;
  final Color? colorWidth;
  final Color? colorContainer;
  final Widget child;

  const ContainerBoder(
      {Key? key,
      required this.child,
      this.boder,
      this.colorContainer,
      this.colorWidth,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorContainer,
          borderRadius: BorderRadius.circular(boder ?? 0),
          border: Border.all(
              width: width ?? 0, color: colorWidth ?? Colors.transparent)),
      child: child,
    );
  }
}
