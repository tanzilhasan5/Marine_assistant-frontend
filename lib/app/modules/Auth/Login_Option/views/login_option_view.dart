import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controllers/login_option_controller.dart';

class LoginOptionView extends GetView<LoginOptionController> {
  const LoginOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Right Step Indicators

              // Logo & App Name / Description
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Images.applogo,
                    height: 100.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Welcome to the Future of\nNavigation NautiGo",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title26_600(color: Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Experience military-grade precision and AI-driven insights for your next coastal or offshore voyage.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
                  ),
                ],
              ),

              SizedBox(height: 60.h,),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSocialButton(
                    iconPath: Images.apple,
                    text: 'Continue in with Apple',
                    onTap: controller.loginWithApple,
                  ),
                  SizedBox(height: 16.h),
                  _buildSocialButton(
                    iconPath: Images.google,
                    text: 'Continue in with Google',
                    onTap: controller.loginWithGoogle,
                  ),
                  SizedBox(height: 16.h),
                  _buildGradientButton(
                    icon: Icons.mail_outline,
                    text: 'Continue in with Email',
                    onTap: controller.loginWithEmail,
                  ),
                ],
              ),
              SizedBox(height: 130.h),

              // Terms & Privacy agreement link
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.title12_w400(color: AppColor.secondarytextColor).copyWith(
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: 'By continuing, you agree to the '),
                    TextSpan(
                      text: 'Terms of Use',
                      style: const TextStyle(
                        color: Color(0xFF0AD5EC),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.snackbar(
                            'Terms of Use',
                            'Displaying Terms of Use...',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                    ),
                    const TextSpan(text: ' and acknowledge that you have read the '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: Color(0xFF0AD5EC),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.snackbar(
                            'Privacy Policy',
                            'Displaying Privacy Policy...',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String iconPath,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        color: const Color(0xFF132A3E),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.r),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 24.h,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 12.w),
              Text(
                text,
                style: AppTextStyles.title16_w600(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
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
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 24.h,
              ),
              SizedBox(width: 12.w),
              Text(
                text,
                style: AppTextStyles.title16_w700(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
