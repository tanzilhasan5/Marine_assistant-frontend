import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/confirm_locaiton_controller.dart';

class ConfirmLocaitonView extends GetView<ConfirmLocaitonController> {
  const ConfirmLocaitonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Confirm Hazard Loaciton',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Subtitle Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select the hazard type closest to what you see.',
                  style: AppTextStyles.title14_w400(
                    color: AppColor.secondarytextColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Upper Map View Canvas
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _ConfirmMapPainter(),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Form Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
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
                  // Note Field Container
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F2639),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note',
                          style: AppTextStyles.title12_w400(
                            color: AppColor.secondarytextColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Expanded(
                          child: TextField(
                            controller: controller.noteController,
                            maxLines: 3,
                            style: AppTextStyles.title14_w400(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write here',
                              hintStyle: AppTextStyles.title14_w400(
                                color: AppColor.secondarytextColor,
                              ),
                              isCollapsed: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Severity Section Header
                  Text(
                    'Severity',
                    style: AppTextStyles.title18_w600(color: Colors.white),
                  ),
                  SizedBox(height: 12.h),

                  // Severity Selection Pill Buttons
                  Obx(() => Row(
                        children: controller.severities.map((sev) {
                          final label = sev['label'] as String;
                          final isSelected =
                              controller.selectedSeverity.value == label;
                          final activeColor = sev['activeColor'] as Color;

                          return Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectSeverity(label),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: label == 'High' ? 0 : 10.w,
                                ),
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF0F2639),
                                  borderRadius: BorderRadius.circular(22.r),
                                  border: isSelected
                                      ? Border.all(
                                          color: activeColor, width: 1.5)
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    label,
                                    style: AppTextStyles.title14_w500(
                                      color: isSelected
                                          ? activeColor
                                          : AppColor.secondarytextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(height: 24.h),

                  // Submit Report Button
                  GestureDetector(
                    onTap: controller.onSubmitReport,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: AppColor.brandLinearGradient,
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      child: Center(
                        child: Text(
                          'Submit Report',
                          style: AppTextStyles.title16_w600(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Map Painter Widget ──────────────────────────────────────────────────────
class _ConfirmMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Grid
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1.0;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Cyan top dot marker
    final topDotPoint = Offset(size.width * 0.5, size.height * 0.25);
    final topDotPaint = Paint()..color = const Color(0xFF0AD5EC);
    canvas.drawCircle(topDotPoint, 12.0, topDotPaint);

    // 3. Route Line
    final startPoint = Offset(size.width * 0.35, size.height * 0.45);
    final endPoint = Offset(size.width * 0.65, size.height * 0.85);

    final linePaint = Paint()
      ..color = const Color(0xFF0AD5EC)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(startPoint, endPoint, linePaint);

    final p1 = Paint()..color = const Color(0xFF0AD5EC);
    canvas.drawCircle(startPoint, 5.0, p1);

    final p2 = Paint()..color = const Color(0xFFFF9800);
    canvas.drawCircle(endPoint, 5.0, p2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
