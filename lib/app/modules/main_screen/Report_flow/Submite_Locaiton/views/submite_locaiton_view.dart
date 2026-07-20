import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../controllers/submite_locaiton_controller.dart';

class SubmiteLocaitonView extends GetView<SubmiteLocaitonController> {
  const SubmiteLocaitonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: controller.onCloseReport,
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Upper Area (Hazard Info Tag + Map Painter)
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Map Background Painter
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _SubmittedMapPainter(),
                    ),
                  ),

                  // Hazard Location Tag Pill
                  Positioned(
                    top: 16.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColor.cardBackground.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Images.alertsRed,
                            width: 16.w,
                            height: 16.h,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 6.w),
                          Obx(() => Text(
                                '• ${controller.locationName.value} •',
                                style: AppTextStyles.title14_w400(
                                    color: Colors.white),
                              )),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFECEB),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Obx(() => Text(
                                  controller.severity.value,
                                  style: AppTextStyles.title12_w500(
                                    color: const Color(0xFFFF483D),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Card Container (Report Submitted)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: AppColor.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Circular Progress Checkmark Ring
                  SizedBox(
                    width: 110.w,
                    height: 110.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(110.w, 110.w),
                          painter: _CheckmarkRingPainter(),
                        ),
                        Icon(
                          Icons.check_rounded,
                          color: const Color(0xFF0AD5EC),
                          size: 48.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Report Submitted Title
                  Text(
                    'Report Submitted',
                    style: AppTextStyles.title24_w600(color: Colors.white),
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

// ─── Checkmark Ring Painter ──────────────────────────────────────────────────
class _CheckmarkRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 12.w) / 2;
    const strokeWidth = 8.0;

    // Track Paint (White)
    final trackPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Active Gradient Arc Paint
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = AppColor.brandLinearGradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -pi / 2, 4.5, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Map Painter ─────────────────────────────────────────────────────────────
class _SubmittedMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1.0;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final startPoint = Offset(size.width * 0.35, size.height * 0.35);
    final endPoint = Offset(size.width * 0.65, size.height * 0.75);

    final linePaint = Paint()
      ..color = const Color(0xFF0AD5EC)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(startPoint, endPoint, linePaint);

    final p1 = Paint()..color = const Color(0xFF0AD5EC);
    canvas.drawCircle(startPoint, 6.0, p1);

    final p2 = Paint()..color = const Color(0xFFFF9800);
    canvas.drawCircle(endPoint, 6.0, p2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
