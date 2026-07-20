import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marine_assistant/app/routes/app_pages.dart';

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
                          style: AppTextStyles.title14_w500(
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
                      InkWell(
                        onTap: (){
                          Get.toNamed(Routes.NOTIFICATION);
                        },
                          child: _IconCircleButton(icon: Icons.notifications_none_rounded)),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: (){
                          Get.toNamed(Routes.PROFILE);

                        },
                          child: _IconCircleButton(icon: Icons.person_outline_rounded)),
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
              SizedBox(height: 24.h),

              // ─── Dynamic View: Active Data vs Empty Route ──────────────
              Obx(() {
                if (controller.hasActiveRoute.value) {
                  return _buildActiveRouteDataView(context);
                } else {
                  return _buildEmptyRouteView(context);
                }
              }),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Active Route & Vessel Data View ──────────────────────────────────────
  Widget _buildActiveRouteDataView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vessel Section Header
        Row(
          children: [
            Image.asset(
              Images.vessel,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.w),
            Text(
              'VESSEL',
              style: AppTextStyles.title12_w600(
                  color: AppColor.secondarytextColor),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Vessel Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Boat Name & Fuel Level
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        controller.vesselName.value,
                        style: AppTextStyles.title18_w600(color: Colors.white),
                      )),
                  Obx(() => Text(
                        '${controller.fuelCurrent.value} / ${controller.fuelTotal.value} L',
                        style: AppTextStyles.title14_w500(
                            color: AppColor.textColor),
                      )),
                ],
              ),
              SizedBox(height: 10.h),

              // Fuel Level Progress Bar
              LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final activeWidth = totalWidth * controller.fuelPercent;
                  return Stack(
                    children: [
                      Container(
                        height: 8.h,
                        width: totalWidth,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A4259),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      Container(
                        height: 8.h,
                        width: activeWidth,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00D8B1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),

              // 4 Stat boxes
              Row(
                children: [
                  _StatBox(value: controller.nm.value, label: 'NM'),
                  SizedBox(width: 8.w),
                  _StatBox(value: controller.hrs.value, label: 'HRS'),
                  SizedBox(width: 8.w),
                  _StatBox(value: controller.lh.value, label: 'L/H'),
                  SizedBox(width: 8.w),
                  _StatBox(value: controller.reserve.value, label: 'RESERVE'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Nearby Alerts Section Header & Toggle
        Row(
          children: [
            Image.asset(
              Images.alertsRed,
              width: 18.w,
              height: 18.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'NEARBY ALERTS',
                style: AppTextStyles.title12_w600(
                    color: AppColor.secondarytextColor),
              ),
            ),
            GestureDetector(
              onTap: controller.toggleAlertsVisibility,
              behavior: HitTestBehavior.opaque,
              child: Obx(() => Icon(
                    controller.isAlertsVisible.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColor.secondarytextColor,
                    size: 24.sp,
                  )),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Nearby Alerts Card with Animated CrossFade Visibility
        Obx(() {
          final isVisible = controller.isAlertsVisible.value;
          return AnimatedCrossFade(
            firstChild: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColor.cardBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: controller.alerts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final alert = entry.value;
                  final isLast = index == controller.alerts.length - 1;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFB3B3),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                alert['title']!,
                                style: AppTextStyles.title14_w400(
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              alert['time']!,
                              style: AppTextStyles.title12_w400(
                                  color: AppColor.secondarytextColor),
                            ),
                          ],
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          color: Colors.white.withValues(alpha: 0.05),
                          height: 1.h,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: isVisible
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 250),
          );
        }),
        SizedBox(height: 32.h),

        // Bottom Action Buttons: Report & Start Navigation
        Row(
          children: [
            // Report Button
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: controller.onReport,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECEB),
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Report',
                      style: AppTextStyles.title16_w600(
                          color: const Color(0xFFFF483D)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Start Navigation Button
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: controller.onStartNavigation,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Start Navigation',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Empty Route View ──────────────────────────────────────────────────────
  Widget _buildEmptyRouteView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.gps_not_fixed_rounded,
              size: 64.sp,
              color: Colors.white.withValues(alpha: 0.7),
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
                    style: AppTextStyles.title16_w600(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat Box Widget ────────────────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  final String value;
  final String label;

  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0F2639),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.title18_w600(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTextStyles.title10_w500(
                  color: AppColor.secondarytextColor),
            ),
          ],
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
