import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.applogo, height: 120.h, fit: BoxFit.contain),
                SizedBox(height: 16.h),
                Text(
                  'NautiGo',
                  style: AppTextStyles.title30_w700(color: AppColor.textColor),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 44.h,
                height: 44.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF0AD5EC),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
