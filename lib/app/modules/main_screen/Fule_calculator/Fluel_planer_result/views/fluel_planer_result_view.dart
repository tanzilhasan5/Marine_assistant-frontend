import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/fluel_planer_result_controller.dart';

class FluelPlanerResultView extends GetView<FluelPlanerResultController> {
  const FluelPlanerResultView({super.key});

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
          'Fuel Planer',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle
              Obx(() => Text(
                    'Results for ${controller.destinationName.value}',
                    style: AppTextStyles.title14_w400(
                      color: AppColor.secondarytextColor,
                    ),
                  )),
              SizedBox(height: 48.h),

              // Circular Safe Margin Gauge
              Center(
                child: Obx(() => SizedBox(
                      width: 170.w,
                      height: 170.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size(170.w, 170.w),
                            painter: _CircularGaugePainter(
                              percentage: controller.safeMarginPercent.value / 100,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${controller.safeMarginPercent.value}%',
                                style: AppTextStyles.title32_w700(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Safe Margin',
                                style: AppTextStyles.title12_w400(
                                  color: AppColor.secondarytextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 36.h),

              // Status Title
              Center(
                child: Obx(() => Text(
                      controller.statusTitle.value,
                      style: AppTextStyles.title24_w600(color: Colors.white),
                    )),
              ),
              SizedBox(height: 48.h),

              // Results Summary Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    // Estimated Fuel Required
                    _ResultMetricRow(
                      label: 'Estimated fuel required',
                      value: controller.estimatedFuelRequired.value,
                    ),
                    SizedBox(height: 16.h),

                    // Estimated Range
                    _ResultMetricRow(
                      label: 'Estimated range',
                      value: controller.estimatedRange.value,
                    ),
                    SizedBox(height: 16.h),

                    // Remaining Safety Margin
                    _ResultMetricRow(
                      label: 'Remaining safety margin',
                      value: controller.remainingSafetyMargin.value,
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

// ─── Result Metric Row Widget ───────────────────────────────────────────────
class _ResultMetricRow extends StatelessWidget {
  final String label;
  final String value;

  const _ResultMetricRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.title14_w400(color: Colors.white),
        ),
        Text(
          value,
          style: AppTextStyles.title14_w400(
            color: AppColor.secondarytextColor,
          ),
        ),
      ],
    );
  }
}

// ─── Circular Gauge Painter ──────────────────────────────────────────────────
class _CircularGaugePainter extends CustomPainter {
  final double percentage;

  _CircularGaugePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16.w) / 2;
    const strokeWidth = 12.0;
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percentage;

    // Background track ring (White)
    final trackPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Active progress arc with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = AppColor.brandLinearGradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
