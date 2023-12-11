import 'package:flutter/material.dart';

Widget customCard({required Widget child, double? width,double? height,double? radius,EdgeInsetsGeometry? padding,EdgeInsetsGeometry? margin, double? blurRadius}) {
  return Container(
    padding: padding,
    margin: margin,
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: blurRadius ?? 10,
        ),
      ],
    ),
    child: child,
  );
}
