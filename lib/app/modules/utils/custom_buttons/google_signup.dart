import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGoogleButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle? textStyle;

  const CustomGoogleButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.height = 44,
    this.width = double.infinity,
    this.borderRadius = 16,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
             SizedBox(width: 10.w),
            Text(
              text,
              style: textStyle
            )
          ],
        ),
      ),
    );
  }
}
