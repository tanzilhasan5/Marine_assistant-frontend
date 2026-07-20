import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controllers/vessel_setup_controller.dart';

class VesselSetupView extends GetView<VesselSetupController> {
  const VesselSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // Top Boat Illustration
              Center(
                child: Image.asset(
                  Images.vessel,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 32.h),

              // Titles
              Text(
                "Chose Vessel Type",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Text(
                "This shapes your routing AI Advice",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
              ),
              const Spacer(flex: 2),

              // 2x2 Grid of Vessel Options
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _buildVesselCard('Sailboat', Images.sailboat, 'Sailboat'),
                      SizedBox(width: 16.w),
                      _buildVesselCard('Motorboat', Images.motorboat, 'Motorboat'),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      _buildVesselCard('Yacht', Images.yacht, 'Yacht'),
                      SizedBox(width: 16.w),
                      _buildVesselCard('RIB/Dinghy', Images.ribDinghy, 'RIB/Dinghy'),
                    ],
                  ),
                ],
              ),
              const Spacer(flex: 4),

              // Continue Button
              Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  gradient: AppColor.brandLinearGradient,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30.r),
                    onTap: controller.goToNextStep,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: AppTextStyles.title16_w700(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Footer: Skip option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You can also update it from the profile  ",
                    style: AppTextStyles.title12_w400(color: AppColor.secondarytextColor),
                  ),
                  GestureDetector(
                    onTap: controller.skipSetup,
                    child: Text(
                      "Do it latter",
                      style: AppTextStyles.title12_w500(color: AppColor.cyanHighlight),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVesselCard(String type, String iconPath, String label) {
    return Expanded(
      child: Obx(() {
        final isSelected = controller.selectedType.value == type;
        return GestureDetector(
          onTap: () => controller.selectVesselType(type),
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: isSelected ? AppColor.brandLinearGradient : null,
              color: isSelected ? null : AppColor.cardBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  height: 32.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 8.h),
                Text(
                  label,
                  style: AppTextStyles.title14_w500(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
