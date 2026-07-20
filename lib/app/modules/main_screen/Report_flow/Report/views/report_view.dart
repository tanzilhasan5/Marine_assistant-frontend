import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              // Main Title Header
              Text(
                'What are you reporting?',
                style: AppTextStyles.title22_w600(color: Colors.white),
              ),
              SizedBox(height: 4.h),

              // Subtitle Header
              Text(
                'Select the hazard type closest to what you see.',
                style: AppTextStyles.title14_w400(
                  color: AppColor.secondarytextColor,
                ),
              ),
              SizedBox(height: 24.h),

              // Warning Triangle Icon
              Center(
                child: Image.asset(
                  Images.alertsRed,
                  width: 56.w,
                  height: 56.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 28.h),

              // 9 Hazard Choice Cards (2 Columns Grid)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.hazards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  final item = controller.hazards[index];

                  return Obx(() {
                    final isSelected =
                        controller.selectedHazard.value == item['name'];

                    return GestureDetector(
                      onTap: () => controller.selectHazard(item['name']!),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? AppColor.brandLinearGradient
                              : null,
                          color: isSelected
                              ? null
                              : const Color(0xFF132A3E),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['icon']!,
                              width: 28.w,
                              height: 28.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              item['name']!,
                              style: AppTextStyles.title14_w500(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
              SizedBox(height: 36.h),

              // Continue Button
              GestureDetector(
                onTap: controller.onContinue,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
