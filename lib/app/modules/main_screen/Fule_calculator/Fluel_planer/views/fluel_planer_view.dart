import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/CustomTextFields/custom_setup_textfield.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../controllers/fluel_planer_controller.dart';

class FluelPlanerView extends GetView<FluelPlanerController> {
  const FluelPlanerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              // Title Header
              Text(
                'Fuel Planer',
                style: AppTextStyles.title22_w600(color: Colors.white),
              ),
              SizedBox(height: 4.h),

              // Subtitle
              Text(
                'Check your range before you depart.',
                style: AppTextStyles.title14_w400(
                  color: AppColor.secondarytextColor,
                ),
              ),
              SizedBox(height: 24.h),

              // Engine Illustration Icon
              Center(
                child: Image.asset(
                  Images.engineIllustration,
                  width: 68.w,
                  height: 68.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 24.h),

              // 1. Start Location
              CustomSetupTextField(
                controller: controller.startLocationController,
                label: 'Start Location',
                hintText: 'Enter your Start Location',
              ),
              SizedBox(height: 12.h),

              // 2. End Location
              CustomSetupTextField(
                controller: controller.endLocationController,
                label: 'End Location',
                hintText: 'Enter your End Location',
              ),
              SizedBox(height: 12.h),

              // 3. Boat Type & Length Row
              Row(
                children: [
                  Expanded(
                    child: CustomSetupTextField(
                      controller: controller.boatTypeController,
                      label: 'Boat Type',
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColor.secondarytextColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomSetupTextField(
                      controller: controller.lengthController,
                      label: 'Length',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // 4. Engine Configuration
              CustomSetupTextField(
                controller: controller.engineConfigController,
                label: 'Engine configuration',
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColor.secondarytextColor,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 12.h),

              // 5. Avg consumption (L/hr) & Available fuel (L) Row
              Row(
                children: [
                  Expanded(
                    child: CustomSetupTextField(
                      controller: controller.avgConsumptionController,
                      label: 'Avg consumption (L/hr)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomSetupTextField(
                      controller: controller.availableFuelController,
                      label: 'Available fuel (L)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // 6. Min. reserve (L) & Route distance (nm) Row
              Row(
                children: [
                  Expanded(
                    child: CustomSetupTextField(
                      controller: controller.minReserveController,
                      label: 'Min. reserve (L)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomSetupTextField(
                      controller: controller.routeDistanceController,
                      label: 'Route distance (nm)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Calculate Range Button
              GestureDetector(
                onTap: controller.onCalculateRange,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Calculate Range',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
