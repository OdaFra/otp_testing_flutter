import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? bodyPadding;
  final EdgeInsetsGeometry? bodyMargin;

  const MainContainer(
      {Key? key, required this.child, this.bodyPadding, this.bodyMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: bodyMargin ?? const EdgeInsets.only(top: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Container(
        padding: bodyPadding,
        child: child,
      ),
    );
  }
}
