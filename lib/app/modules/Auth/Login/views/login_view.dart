import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marine_assistant/app/routes/app_pages.dart';

import '../../../utils/CustomTextFields/custom_TextFields.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                "Sign In",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Text(
                "Enter your email to sign in",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(
                  color: AppColor.secondarytextColor,
                ),
              ),
              SizedBox(height: 48.h),
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
                    onTap: controller.login,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: AppTextStyles.title16_w700(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 350.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppTextStyles.title14_w500(
                      color: AppColor.secondarytextColor,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.SIGN_UP);
                    },
                    child: Text(
                      'Sign up',
                      style: AppTextStyles.title25_w500(
                        color: AppColor.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
