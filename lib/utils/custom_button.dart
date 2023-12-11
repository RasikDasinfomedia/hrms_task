import 'package:flutter/material.dart';
import 'package:hrms_task/utils/hrms_colors.dart';
import 'package:hrms_task/utils/hrms_style.dart';

Widget customButton({
  VoidCallback? onPressed,
  double? width,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  IconData? icon,
  String? title,
  double? height,
}) {
  return Container(
    width: width,
    margin: margin,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: selectedTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 5)),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 16.0,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 3, right: 5),
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: buttonTextStyle,
            ),
          ),
        ],
      ),
    ),
  );
}
