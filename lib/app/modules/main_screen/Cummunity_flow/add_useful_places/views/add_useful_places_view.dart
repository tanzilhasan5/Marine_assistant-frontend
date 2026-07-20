import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/CustomTextFields/custom_setup_textfield.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/add_useful_places_controller.dart';

class AddUsefulPlacesView extends GetView<AddUsefulPlacesController> {
  const AddUsefulPlacesView({super.key});

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

            // Upper Map Canvas View
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _AddPlaceMapPainter(),
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
                  // 1. Place Name
                  CustomSetupTextField(
                    controller: controller.placeNameController,
                    label: 'Place Name',
                    hintText: 'Write here',
                  ),
                  SizedBox(height: 12.h),

                  // 2. Select Category
                  CustomSetupTextField(
                    controller: controller.categoryController,
                    label: 'Select Category',
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColor.secondarytextColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // 3. Status
                  CustomSetupTextField(
                    controller: controller.statusController,
                    label: 'Status',
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColor.secondarytextColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Submit Places Button
                  GestureDetector(
                    onTap: controller.onSubmitPlaces,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: AppColor.brandLinearGradient,
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      child: Center(
                        child: Text(
                          'Submit Places',
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
class _AddPlaceMapPainter extends CustomPainter {
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

    final topDotPoint = Offset(size.width * 0.52, size.height * 0.22);
    final topDotPaint = Paint()..color = const Color(0xFF0AD5EC);
    canvas.drawCircle(topDotPoint, 14.0, topDotPaint);

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
