import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/verifed_controller.dart';

class VerifedView extends GetView<VerifedController> {
  const VerifedView({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifedController controller = Get.put(VerifedController());
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120.w,
                  height: 120.h,
                  child: CustomPaint(
                    painter: GradientRingPainter(),
                  ),
                ),
                Icon(
                  Icons.check,
                  size: 48.h,
                  color: AppColor.blueHighlight,
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Text(
              "Verified",
              style: AppTextStyles.title26_600(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 8.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    paint.color = Colors.white;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      0.75 * 3.14159,
      1.0 * 3.14159,
      false,
      paint,
    );

    const gradient = SweepGradient(
      colors: [
        AppColor.blueHighlight,
        AppColor.cyanHighlight,
      ],
      stops: [0.0, 1.0],
    );
    paint.shader = gradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      1.75 * 3.14159,
      1.0 * 3.14159,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
