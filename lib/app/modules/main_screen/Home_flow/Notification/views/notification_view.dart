import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

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
          'Notification',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.notifications.isEmpty) {
            return Center(
              child: Text(
                'No notifications available',
                style: AppTextStyles.title16_w400(
                  color: AppColor.secondarytextColor,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            itemCount: controller.notifications.length,
            separatorBuilder: (context, index) => SizedBox(height: 14.h),
            itemBuilder: (context, index) {
              final item = controller.notifications[index];

              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row: Blue dot + Title + Close icon
                    Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF64B5F6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            item.title,
                            style: AppTextStyles.title16_w600(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.removeNotification(index),
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Description text
                    Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      child: Text(
                        item.description,
                        style: AppTextStyles.title14_w400(
                          color: AppColor.secondarytextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
