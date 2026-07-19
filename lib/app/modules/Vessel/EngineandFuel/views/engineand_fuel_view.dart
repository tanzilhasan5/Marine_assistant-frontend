import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/CustomTextFields/custom_setup_textfield.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controllers/engineand_fuel_controller.dart';

class EngineandFuelView extends GetView<EngineandFuelController> {
  const EngineandFuelView({super.key});

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Engine Illustration
              Center(
                child: Image.asset(
                  Images.engineIllustration,
                  height: 80.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 24.h),

              // Title Headers
              Text(
                "Engine & Fuel",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 8.h),
              Text(
                "This shapes your routing AI Advice",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
              ),
              SizedBox(height: 32.h),

              // 2x2 Grid of Engine Options
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _buildEngineCard('Diesel', Images.diesel, 'Diesel'),
                      SizedBox(width: 16.w),
                      _buildEngineCard('Petrol', Images.diesel, 'Petrol'), // uses diesel as fallback red can icon
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      _buildEngineCard('Electric', Images.electric, 'Electric'),
                      SizedBox(width: 16.w),
                      _buildEngineCard('Hybrid', Images.hybrid, 'Hybrid'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Step indicator slider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.w,
                    height: 2.h,
                    color: AppColor.cyanHighlight,
                  ),
                  SizedBox(width: 3.w,),

                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: AppColor.cyanHighlight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 3.w,),

                  Container(
                    width: 50.w,
                    height: 2.h,
                    color: AppColor.cyanHighlight,
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Fuel & engine form inputs
              CustomSetupTextField(
                controller: controller.motorController,
                label: 'Motor',
                hintText: '2',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.tankCapacityController,
                label: 'Tank capacity (liters)',
                hintText: '200',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.currentLitersController,
                label: 'Current (liters)',
                hintText: '200',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.reserveMarginController,
                label: 'Reserve Margin (%)',
                hintText: '15',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.consumptionController,
                label: 'Consumption (L/h at cruise)',
                hintText: '8',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.cruiseSpeedController,
                label: 'Cruise Speed',
                hintText: '7',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 48.h),

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
                    onTap: controller.continueToNavbar,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: AppTextStyles.title16_w700(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEngineCard(String type, String iconPath, String label) {
    return Expanded(
      child: Obx(() {
        final isSelected = controller.selectedEngineType.value == type;
        return GestureDetector(
          onTap: () => controller.selectEngineType(type),
          child: Container(
            height: 90.h,
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
                  height: 28.h,
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
