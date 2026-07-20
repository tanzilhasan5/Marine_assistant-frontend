import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

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
          'FAQ',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.faqs.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final faq = controller.faqs[index];

                        return Obx(() {
                          final isExpanded =
                              controller.expandedIndex.value == index;

                          return GestureDetector(
                            onTap: () => controller.toggleExpand(index),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColor.cardBackground,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Question Header Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          faq.question,
                                          style: AppTextStyles.title16_w500(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                        size: 24.sp,
                                      ),
                                    ],
                                  ),

                                  // Expanded Answer Section
                                  if (isExpanded) ...[
                                    SizedBox(height: 12.h),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Left vertical accent line
                                        Container(
                                          width: 2.w,
                                          height: 48.h,
                                          color: AppColor.secondarytextColor,
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            faq.answer,
                                            style: AppTextStyles.title14_w400(
                                              color:
                                                  AppColor.secondarytextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Button: Need Support?
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: controller.onNeedSupport,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Need Support?',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
