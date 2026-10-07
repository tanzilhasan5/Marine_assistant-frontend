import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';
import '../styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color backgroundColor;
  final double height;
  final double width;
  final Color borderColor;
  final bool isLoading;

  // Optional gradient
  final Gradient? gradient;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.borderRadius = 30,
    this.backgroundColor = AppColor.primary,
    this.height = 60,
    this.width = double.infinity,
    this.borderColor = Colors.transparent,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: height.h,
        width: width.w,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? backgroundColor : null,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.title20_w700(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}