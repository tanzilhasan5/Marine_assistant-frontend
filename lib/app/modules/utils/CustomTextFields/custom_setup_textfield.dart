import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors.dart';
import '../styles.dart';

class CustomSetupTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType keyboardType;

  const CustomSetupTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.title12_w400(color: AppColor.secondarytextColor),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 24.h,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: AppTextStyles.title16_w500(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.title16_w400(color: AppColor.secondarytextColor),
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
