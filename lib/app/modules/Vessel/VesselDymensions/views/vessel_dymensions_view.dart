import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/CustomTextFields/custom_setup_textfield.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controllers/vessel_dymensions_controller.dart';

class VesselDymensionsView extends GetView<VesselDymensionsController> {
  const VesselDymensionsView({super.key});

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
              // Top 3D Dimension Box Illustration
              Center(
                child: Image.asset(
                  Images.vesselDimensions,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 32.h),

              // Title Headers
              Text(
                "Vessel Dimensions",
                textAlign: TextAlign.center,
                style: AppTextStyles.title26_600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Text(
                "Used for depth & clearance checks",
                textAlign: TextAlign.center,
                style: AppTextStyles.title14_w400(color: AppColor.secondarytextColor),
              ),
              SizedBox(height: 40.h),

              // Inputs for Dimensions
              CustomSetupTextField(
                controller: controller.nameController,
                label: 'Vessel Name',
                hintText: 'Stella Del Mare',
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.lengthController,
                label: 'Length (m)',
                hintText: '12',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.beamController,
                label: 'Beam (m)',
                hintText: '3.8',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.draftController,
                label: 'Draft (m)',
                hintText: '1.8',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16.h),
              CustomSetupTextField(
                controller: controller.airDraftController,
                label: 'Air Draft (m)',
                hintText: '16',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 48.h),

              // Save Button
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
                    onTap: controller.saveVessel,
                    child: Center(
                      child: Text(
                        'Save Vessel',
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
}
