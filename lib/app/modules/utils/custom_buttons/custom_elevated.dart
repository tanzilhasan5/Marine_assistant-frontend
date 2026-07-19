
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


  const CustomButton({
    super.key,
    this.isLoading = false,
    required this.text,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.backgroundColor = AppColor.primary,
    this.height = 60,
    this.width = double.infinity,
    this.borderColor = Colors.transparent
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
        :
      SizedBox(
      height: height.h,
      width: width.w ,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor,),
          ),
        ),
        child: Text(text, style: AppTextStyles.title20_w700(color: Colors.white
          ),
        ),
      ),
    );
  }
}
