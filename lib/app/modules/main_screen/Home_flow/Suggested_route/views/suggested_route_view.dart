import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../controllers/suggested_route_controller.dart';

class SuggestedRouteView extends GetView<SuggestedRouteController> {
  const SuggestedRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: Obx(() {
          final isNavigating = controller.isNavigating.value;
          return AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: isNavigating
                ? null
                : IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
            title: isNavigating
                ? null
                : Text(
                    'Plan a Route',
                    style: AppTextStyles.title20_w600(color: Colors.white),
                  ),
            centerTitle: false,
            actions: isNavigating
                ? [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: controller.onEndNavigation,
                    ),
                    SizedBox(width: 8.w),
                  ]
                : null,
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ─── Upper Canvas Area (Full Marine Chart Map View) ──────────────
            Expanded(
              child: Stack(
                children: [
                  // Marine map background painter
                  Positioned.fill(
                    child: CustomPaint(painter: _RouteLinePainter()),
                  ),

                  // Floating Map Action / Layer Buttons (Top Right)
                  Positioned(
                    top: 16.h,
                    right: 16.w,
                    child: Column(
                      children: [
                        _MapActionButton(
                          icon: Icons.layers_outlined,
                          onTap: () {},
                        ),
                        SizedBox(height: 10.h),
                        _MapActionButton(
                          icon: Icons.my_location_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // Start Location Marker with Vessel Icon
                  Positioned(
                    left: 50.w,
                    top: 40.h,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColor.cardBackground,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.cyanHighlight,
                              width: 2,
                            ),
                          ),
                          child: Image.asset(
                            Images.ship,
                            width: 24.w,
                            height: 24.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.cardBackground.withValues(
                              alpha: 0.85,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'Start',
                            style: AppTextStyles.title10_w500(
                              color: AppColor.cyanHighlight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Destination Marker Pin
                  Positioned(
                    right: 60.w,
                    bottom: 30.h,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: const Color(0xFFFF9800),
                          size: 32.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.cardBackground.withValues(
                              alpha: 0.85,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'Destination',
                            style: AppTextStyles.title10_w500(
                              color: const Color(0xFFFF9800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ─── Bottom Card Container ─────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: AppColor.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destination Title
                  Obx(
                    () => Text(
                      controller.destinationName.value,
                      style: AppTextStyles.title22_w600(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // 3 Stat Metric Cards
                  Row(
                    children: [
                      _StatMetricCard(
                        value: controller.distance.value,
                        label: 'Distance',
                      ),
                      SizedBox(width: 12.w),
                      _StatMetricCard(
                        value: controller.eta.value,
                        label: 'ETA',
                      ),
                      SizedBox(width: 12.w),
                      _StatMetricCard(
                        value: controller.aveSpeed.value,
                        label: 'Ave. Speed',
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Warning Alerts List Header & Toggle
                  Obx(() {
                    final isVisible = controller.isAlertsVisible.value;
                    return Column(
                      children: [
                        AnimatedCrossFade(
                          firstChild: Column(
                            children: controller.alerts.map((alert) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      alert['icon'] as String,
                                      width: 20.w,
                                      height: 20.h,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        alert['text'] as String,
                                        style: AppTextStyles.title14_w500(
                                          color: alert['color'] as Color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          secondChild: const SizedBox.shrink(),
                          crossFadeState: isVisible
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 250),
                        ),
                        GestureDetector(
                          onTap: controller.toggleAlertsVisibility,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isVisible
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: AppColor.secondarytextColor,
                                  size: 24.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 12.h),

                  // Dynamic Action Button (Start Navigate vs End Navigation)
                  Obx(() {
                    final isNavigating = controller.isNavigating.value;
                    return GestureDetector(
                      onTap: isNavigating
                          ? controller.onEndNavigation
                          : controller.onStartNavigate,
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          gradient: AppColor.brandLinearGradient,
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        child: Center(
                          child: Text(
                            isNavigating ? 'End Navigation' : 'Start Navigate',
                            style: AppTextStyles.title16_w600(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 12.h),

                  // Edit Route Button (Hidden in Active Navigation Mode)
                  Obx(() {
                    if (controller.isNavigating.value) {
                      return const SizedBox.shrink();
                    }
                    return Center(
                      child: GestureDetector(
                        onTap: controller.onEditRoute,
                        child: Text(
                          'Edit Route',
                          style: AppTextStyles.title14_w500(
                            color: AppColor.secondarytextColor,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat Metric Card Widget ────────────────────────────────────────────────
class _StatMetricCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatMetricCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0F2639),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.title18_w600(color: Colors.white)),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyles.title12_w400(
                color: AppColor.secondarytextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Route Line Custom Painter ──────────────────────────────────────────────
class _RouteLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw marine nautical grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Draw subtle depth contour curves
    final contourPaint = Paint()
      ..color = const Color(0xFF0AD5EC).withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path1 = Path()
      ..moveTo(0, size.height * 0.3)
      ..cubicTo(
        size.width * 0.4,
        size.height * 0.2,
        size.width * 0.6,
        size.height * 0.5,
        size.width,
        size.height * 0.4,
      );
    canvas.drawPath(path1, contourPaint);

    final path2 = Path()
      ..moveTo(0, size.height * 0.7)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.6,
        size.width * 0.7,
        size.height * 0.9,
        size.width,
        size.height * 0.8,
      );
    canvas.drawPath(path2, contourPaint);

    // 3. Main route line
    final startPoint = Offset(size.width * 0.25, size.height * 0.2);
    final endPoint = Offset(size.width * 0.75, size.height * 0.8);

    final linePaint = Paint()
      ..color = const Color(0xFF0AD5EC)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(startPoint, endPoint, linePaint);

    // 4. Start Point: Cyan dot with glowing outer pulse ring
    final startPulsePaint = Paint()
      ..color = const Color(0xFF0AD5EC).withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(startPoint, 14.0, startPulsePaint);

    final startDotPaint = Paint()..color = const Color(0xFF0AD5EC);
    canvas.drawCircle(startPoint, 6.0, startDotPaint);

    // 5. End Point: Orange dot with glowing outer pulse ring
    final endPulsePaint = Paint()
      ..color = const Color(0xFFFF9800).withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(endPoint, 14.0, endPulsePaint);

    final endDotPaint = Paint()..color = const Color(0xFFFF9800);
    canvas.drawCircle(endPoint, 6.0, endDotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Floating Map Action Button Widget ──────────────────────────────────────
class _MapActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: AppColor.cardBackground.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColor.textColor, size: 20.sp),
      ),
    );
  }
}
