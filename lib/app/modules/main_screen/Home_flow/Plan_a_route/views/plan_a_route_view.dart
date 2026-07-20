import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/plan_a_route_controller.dart';

class PlanARouteView extends GetView<PlanARouteController> {
  const PlanARouteView({super.key});

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
          'Plan a Route',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Question Title
              Text(
                'Where are you headed?',
                style: AppTextStyles.title22_w600(color: Colors.white),
              ),
              SizedBox(height: 16.h),

              // Search Field
              Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: TextField(
                  controller: controller.searchController,
                  style: AppTextStyles.title16_w500(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Destination',
                    hintStyle: AppTextStyles.title16_w400(
                      color: AppColor.secondarytextColor,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.secondarytextColor,
                      size: 22.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // RECENT Header
              Text(
                'RECENT',
                style: AppTextStyles.title12_w600(
                  color: AppColor.secondarytextColor,
                ),
              ),
              SizedBox(height: 12.h),

              // Recent Destinations List
              Obx(() => Column(
                    children: controller.recentDestinations.map((item) {
                      final isSelected =
                          controller.selectedDestination.value == item['name'];
                      return InkWell(
                        onTap: () =>
                            controller.selectDestination(item['name']!),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColor.cyanHighlight,
                                size: 22.sp,
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  item['name']!,
                                  style: AppTextStyles.title16_w500(
                                    color: isSelected
                                        ? AppColor.cyanHighlight
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                item['distance']!,
                                style: AppTextStyles.title14_w400(
                                  color: AppColor.secondarytextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )),
              SizedBox(height: 24.h),

              // Drop Pin On Map Button
              GestureDetector(
                onTap: controller.onDropPinOnMap,
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: AppColor.cardBackground.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(27.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Drop pin on map',
                      style: AppTextStyles.title16_w500(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Continue Button
              GestureDetector(
                onTap: controller.onContinue,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
