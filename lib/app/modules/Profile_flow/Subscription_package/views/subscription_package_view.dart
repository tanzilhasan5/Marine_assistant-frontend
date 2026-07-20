import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/subscription_package_controller.dart';

class SubscriptionPackageView
    extends GetView<SubscriptionPackageController> {
  const SubscriptionPackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Close Button
            Positioned(
              top: 12.h,
              right: 16.w,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),

            // Body Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 44.h),

                  // Main Heading
                  Text(
                    'Precision Intelligence.',
                    style: AppTextStyles.title26_600(color: Colors.white),
                  ),
                  SizedBox(height: 8.h),

                  // Subtitle
                  Text(
                    'Unlock advanced navigation intelligence,\nenhanced safety tools, and premium marine\ninsights.',
                    style: AppTextStyles.title14_w400(
                      color: AppColor.secondarytextColor,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Feature Checklist Items
                  _FeatureCheckItem(title: 'AI Route Optimization'),
                  SizedBox(height: 12.h),
                  _FeatureCheckItem(title: 'Weather Insights'),
                  SizedBox(height: 12.h),
                  _FeatureCheckItem(title: 'Fuel Analytics'),
                  SizedBox(height: 12.h),
                  _FeatureCheckItem(title: 'Safety Alerts'),
                  SizedBox(height: 12.h),
                  _FeatureCheckItem(title: 'Community Insights'),

                  const Spacer(),

                  // Pricing Cards Row
                  Obx(() => Row(
                        children: [
                          // Card 1: Weekly
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectPlan('Weekly'),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 90.h,
                                padding: EdgeInsets.all(14.w),
                                decoration: BoxDecoration(
                                  gradient: controller.selectedPlan.value ==
                                          'Weekly'
                                      ? AppColor.brandLinearGradient
                                      : null,
                                  color: controller.selectedPlan.value ==
                                          'Weekly'
                                      ? null
                                      : AppColor.cardBackground,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Weekly',
                                      style: AppTextStyles.title12_w400(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '\$29.99 / Weekly',
                                      style: AppTextStyles.title16_w600(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),

                          // Card 2: Annual
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectPlan('Annual'),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 90.h,
                                padding: EdgeInsets.all(14.w),
                                decoration: BoxDecoration(
                                  gradient: controller.selectedPlan.value ==
                                          'Annual'
                                      ? AppColor.brandLinearGradient
                                      : null,
                                  color: controller.selectedPlan.value ==
                                          'Annual'
                                      ? null
                                      : AppColor.cardBackground,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Annual',
                                      style: AppTextStyles.title12_w400(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '\$199.99 / Year',
                                      style: AppTextStyles.title16_w600(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 28.h),

                  // Bottom Action Button: Unlock Access
                  GestureDetector(
                    onTap: controller.onUnlockAccess,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: AppColor.brandLinearGradient,
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      child: Center(
                        child: Text(
                          'Unlock Access',
                          style: AppTextStyles.title16_w600(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Feature Check Item Widget ───────────────────────────────────────────────
class _FeatureCheckItem extends StatelessWidget {
  final String title;

  const _FeatureCheckItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: const BoxDecoration(
            color: Color(0xFF00D8B1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 16.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: AppTextStyles.title14_w500(color: Colors.white),
        ),
      ],
    );
  }
}
