import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // ─── Header ──────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURRENT POSITION',
                          style: AppTextStyles.title10_w500(
                              color: AppColor.secondarytextColor),
                        ),
                        SizedBox(height: 2.h),
                        Obx(() => Text(
                              controller.locationName.value,
                              style: AppTextStyles.title22_w600(
                                  color: AppColor.textColor),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _IconCircleButton(icon: Icons.notifications_none_rounded),
                      SizedBox(width: 10.w),
                      _IconCircleButton(icon: Icons.person_outline_rounded),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // ─── Marine Conditions Card ───────────────────────────────
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MARRINE CONDITIONS',
                      style: AppTextStyles.title10_w500(
                          color: AppColor.secondarytextColor),
                    ),
                    SizedBox(height: 14.h),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _ConditionItem(
                              imagePath: Images.windNe,
                              value: controller.wind.value,
                              label: controller.windDir.value,
                            ),
                            _ConditionItem(
                              imagePath: Images.wave,
                              value: controller.wave.value,
                              label: 'Wave',
                            ),
                            _ConditionItem(
                              imagePath: Images.temp,
                              value: controller.temp.value,
                              label: 'Temp',
                            ),
                            _ConditionItem(
                              imagePath: Images.visibility,
                              value: controller.visibility.value,
                              label: 'Visibility',
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(height: 56.h),

              // ─── Empty Route State ────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.gps_not_fixed_rounded,
                      size: 64.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'No active route yet',
                      style: AppTextStyles.title20_w600(color: Colors.white),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Plan your first route to get fuel-aware, hazard-checked\nguidance.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title14_w400(
                          color: AppColor.secondarytextColor),
                    ),
                    SizedBox(height: 32.h),

                    // Plan a Route button
                    GestureDetector(
                      onTap: controller.onStartNavigation,
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          gradient: AppColor.brandLinearGradient,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: Text(
                            'Plan a Route',
                            style:
                                AppTextStyles.title16_w600(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Condition Item Widget ──────────────────────────────────────────────────
class _ConditionItem extends StatelessWidget {
  final String imagePath;
  final String value;
  final String label;

  const _ConditionItem({
    required this.imagePath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 28.w, height: 28.h, fit: BoxFit.contain),
        SizedBox(height: 6.h),
        Text(
          value,
          style: AppTextStyles.title16_w600(color: AppColor.textColor),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.title10_w500(color: AppColor.secondarytextColor),
        ),
      ],
    );
  }
}

// ─── Icon Circle Button ─────────────────────────────────────────────────────
class _IconCircleButton extends StatelessWidget {
  final IconData icon;
  const _IconCircleButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColor.textColor, size: 20.sp),
    );
  }
}
