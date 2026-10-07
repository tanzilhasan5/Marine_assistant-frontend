/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marine_assistant/app/modules/utils/custom_buttons/custom_elevated.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/login_otp_controller.dart';

class LoginOtpView extends GetView<LoginOtpController > {
  const LoginOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments;
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
                "OTP",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Text(
                "An email with the code has been sent to\n${email}",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor).copyWith(
                  height: 1.5,
                ),
              ),
              SizedBox(height: 48.h),

              // OTP Pin Input Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: controller.pinController,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 150),
                  cursorColor: Colors.white,
                  enableActiveFill: true,
                  hintCharacter: '•',
                  hintStyle: AppTextStyles.title20_w700(color: AppColor.secondarytextColor),
                  textStyle: AppTextStyles.title20_w700(color: Colors.white),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(16.r),
                    fieldHeight: 48.h,
                    fieldWidth: 48.w,
                    activeFillColor: AppColor.cardBackground,
                    inactiveFillColor: AppColor.cardBackground,
                    selectedFillColor: AppColor.cyanHighlight,
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                  ),
                  onChanged: (value) {},
                  onCompleted: (value) {
                    controller.verifyOtp();
                  },
                ),
              ),
              SizedBox(height: 48.h),

              // Continue Button

              Obx(()=>

                CustomButton(text: 'Continue',
                    gradient: AppColor.brandLinearGradient,
                    isLoading: controller.isLoading.value,
                    onPressed: (){
                  controller.verifryOtp(email, controller.pinController.text);


                }),
              ),
              SizedBox(height: 32.h),

              // Resend code option
              Obx(() {
                final isActive = controller.isTimerActive.value;
                final seconds = controller.secondsRemaining.value;

                return GestureDetector(
                  onTap: (){

                    if(!controller.isTimerActive.value){
                      controller.resend(email);
                    }

                    },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
                      children: [
                        if (isActive) ...[
                          const TextSpan(text: "Resend code in "),
                          TextSpan(
                            text: "${seconds}s",
                            style: AppTextStyles.title14_w500(color: AppColor.cyanHighlight),
                          ),
                        ] else ...[
                          const TextSpan(text: "Didn't get the code? "),
                          TextSpan(
                            text: 'Try Again',
                            style: AppTextStyles.title14_w500(color: AppColor.cyanHighlight),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marine_assistant/app/modules/utils/custom_buttons/custom_elevated.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/login_otp_controller.dart';

class LoginOtpView extends GetView<LoginOtpController> {
  const LoginOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments;
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
                "OTP",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Text(
                "An email with the code has been sent to\n$email",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor)
                    .copyWith(height: 1.5),
              ),
              SizedBox(height: 48.h),

              // OTP Pin Input Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: controller.pinController,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 150),
                  cursorColor: Colors.white,
                  enableActiveFill: true,
                  hintCharacter: '•',
                  hintStyle: AppTextStyles.title20_w700(color: AppColor.secondarytextColor),
                  textStyle: AppTextStyles.title20_w700(color: Colors.white),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(16.r),
                    fieldHeight: 48.h,
                    fieldWidth: 48.w,
                    activeFillColor: AppColor.cardBackground,
                    inactiveFillColor: AppColor.cardBackground,
                    selectedFillColor: AppColor.cyanHighlight,
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                  ),
                  onChanged: (value) {},
                  onCompleted: (value) {
                    controller.verifyOtp();
                  },
                ),
              ),
              SizedBox(height: 48.h),

              // Continue Button — only reacts to isLoading (OTP verify),
              // never to the resend/"Try Again" action.
              Obx(
                    () => CustomButton(
                  text: 'Continue',
                  gradient: AppColor.brandLinearGradient,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.verifryOtp(email, controller.pinController.text);
                  },
                ),
              ),
              SizedBox(height: 32.h),

              // Resend code option
              Obx(() {
                final isActive = controller.isTimerActive.value;
                final seconds = controller.secondsRemaining.value;
                final isResendLoading = controller.isResendLoading.value;

                return GestureDetector(
                  onTap: () {
                    if (!isActive && !isResendLoading) {
                      controller.resend(email);
                    }
                  },
                  child: isResendLoading
                      ? Center(child: Text('Resending ......',style: AppTextStyles.title18_w400(color: AppColor.cyanHighlight),))
                      : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.title14_w400(
                        color: AppColor.secondarytextColor,
                      ),
                      children: [
                        if (isActive) ...[
                          const TextSpan(text: "Resend code in "),
                          TextSpan(
                            text: "${seconds}s",
                            style: AppTextStyles.title14_w500(
                              color: AppColor.cyanHighlight,
                            ),
                          ),
                        ] else ...[
                          const TextSpan(text: "Didn't get the code? "),
                          TextSpan(
                            text: 'Try Again',
                            style: AppTextStyles.title14_w500(
                              color: AppColor.cyanHighlight,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}