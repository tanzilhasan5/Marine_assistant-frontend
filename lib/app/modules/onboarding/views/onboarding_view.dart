import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/custom_buttons/custom_elevated.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      Images.onboarding1,
      Images.onboarding2,
      Images.onboarding3,
    ];

    final List<String> titles = [
      "Navigate Smarter Across Every Journey",
      "Share and View Community Reports",
      "Travel Further With Confidence",
    ];

    final List<String> descriptions = [
      "AI-powered routing helps you find safer, more efficient paths while adapting to real-time marine conditions.",
      "Report hazards, heavy traffic, and unlit buoys. Stay updated with real-time feedback from fellow mariners.",
      "Monitor fuel usage, optimize range, and receive intelligent recommendations tailored to your vessel.",
    ];

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    images[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColor.primary.withOpacity(0.4),
                            AppColor.primary.withOpacity(0.85),
                            AppColor.primary,
                          ],
                          stops: const [0.0, 0.45, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40.h,
                    left: 24.w,
                    right: 24.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          titles[index],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title26_600(color: AppColor.textColor),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          descriptions[index],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
                        ),
                        SizedBox(height: 32.h),
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(images.length, (dotIndex) {
                            final isActive = dotIndex == controller.currentPage.value;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: isActive ? 24.w : 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                gradient: isActive ? AppColor.brandLinearGradient : null,
                                color: isActive ? null : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }),
                        )),
                        SizedBox(height: 40.h),
                        Container(
                          width: double.infinity,
                          height: 60.h,
                          decoration: BoxDecoration(
                            gradient: AppColor.brandLinearGradient,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: CustomButton(
                            text: 'Next',
                            backgroundColor: Colors.transparent,
                            borderRadius: 30.r,
                            onPressed: controller.nextPage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

        ],
      ),
    );
  }
}
