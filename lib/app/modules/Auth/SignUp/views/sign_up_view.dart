import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/CustomTextFields/custom_TextFields.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Text(
                "Enter your email to sign up",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
              ),
              SizedBox(height: 48.h),
              CustomtextField(
                controller: controller.nameController,
                hintText: 'Enter your name',
                backgroundColor: const Color(0xFF132A3E),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              SizedBox(height: 16.h),
              CustomtextField(
                controller: controller.emailController,
                hintText: 'Your Email',
                keyboardType: TextInputType.emailAddress,
                backgroundColor: const Color(0xFF132A3E),
                prefixIcon: const Icon(Icons.mail_outline),
              ),
              SizedBox(height: 48.h),
              Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  gradient: AppColor.brandLinearGradient,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30.r),
                    onTap: controller.signUp,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: AppTextStyles.title16_w700(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
