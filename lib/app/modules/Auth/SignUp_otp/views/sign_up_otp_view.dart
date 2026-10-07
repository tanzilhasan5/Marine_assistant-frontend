

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/sign_up_otp_controller.dart';

class SignUpOtpView extends GetView<SignUpOtpController> {
  const SignUpOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments as String;

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
                style: AppTextStyles.title26_600(
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                "An email with the code has been sent to\n$email",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(
                  color: AppColor.secondarytextColor,
                ).copyWith(
                  height: 1.5,
                ),
              ),

              SizedBox(height: 48.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: controller.pinController,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(
                    milliseconds: 150,
                  ),
                  cursorColor: Colors.white,
                  enableActiveFill: true,
                  hintCharacter: '•',
                  hintStyle: AppTextStyles.title20_w700(
                    color: AppColor.secondarytextColor,
                  ),
                  textStyle: AppTextStyles.title20_w700(
                    color: Colors.white,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(16.r),
                    fieldHeight: 56.h,
                    fieldWidth: 46.w,
                    activeFillColor: AppColor.cardBackground,
                    inactiveFillColor: AppColor.cardBackground,
                    selectedFillColor: AppColor.cyanHighlight,
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                  ),
                  onChanged: (value) {},
                ),
              ),

              SizedBox(height: 48.h),

              Obx(
                    () => Container(
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
                      onTap: controller.isLoading.value
                          ? null
                          : () {
                        controller.otpverifry(
                          email,
                          controller.pinController.text,
                        );
                      },
                      child: Center(
                        child: controller.isLoading.value
                            ? SizedBox(
                          width: 22.w,
                          height: 22.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          'Continue',
                          style: AppTextStyles.title16_w700(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              Obx(
                    () {
                  final isActive =
                      controller.isTimerActive.value;
                  final seconds =
                      controller.secondsRemaining.value;
                  final isResendLoading =
                      controller.isResendLoading.value;

                  return GestureDetector(
                    onTap: () {
                      if (!isActive && !isResendLoading) {
                        controller.resend(email);
                      }
                    },
                    child:
                    SizedBox(
                      height: 24.h,
                      child: Center(
                        child: isResendLoading
                            ?
                        Center(child: Text('Resending ......',style: AppTextStyles.title18_w400(color: AppColor.cyanHighlight),))
                            : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style:
                            AppTextStyles.title14_w400(
                              color: AppColor
                                  .secondarytextColor,
                            ),
                            children: [
                              if (isActive) ...[
                                const TextSpan(
                                  text: "Resend code in ",
                                ),
                                TextSpan(
                                  text: "${seconds}s",
                                  style: AppTextStyles
                                      .title14_w500(
                                    color: AppColor
                                        .cyanHighlight,
                                  ),
                                ),
                              ] else ...[
                                const TextSpan(
                                  text:
                                  "Didn't get the code? ",
                                ),
                                TextSpan(
                                  text: 'Try Again',
                                  style: AppTextStyles
                                      .title14_w500(
                                    color: AppColor
                                        .cyanHighlight,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}