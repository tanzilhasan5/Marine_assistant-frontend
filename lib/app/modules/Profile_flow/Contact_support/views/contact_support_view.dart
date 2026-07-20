import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/contact_support_controller.dart';

class ContactSupportView extends GetView<ContactSupportController> {
  const ContactSupportView({super.key});

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
          'Contact Support',
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

                    // Opinion / Report / Problem Input Field
                    Container(
                      width: double.infinity,
                      height: 120.h,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColor.cardBackground,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Opinion / Report / Problem',
                            style: AppTextStyles.title12_w400(
                              color: AppColor.secondarytextColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Expanded(
                            child: TextField(
                              controller: controller.messageController,
                              maxLines: 4,
                              style: AppTextStyles.title14_w400(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Write here',
                                hintStyle: AppTextStyles.title14_w400(
                                  color: AppColor.secondarytextColor,
                                ),
                                isCollapsed: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Attached File Upload Container
                    GestureDetector(
                      onTap: controller.onUploadFile,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 130.h,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.cardBackground,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Attached File',
                              style: AppTextStyles.title12_w400(
                                color: AppColor.secondarytextColor,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Obx(() {
                                  if (controller
                                      .attachedFileName.value.isNotEmpty) {
                                    return Text(
                                      controller.attachedFileName.value,
                                      style: AppTextStyles.title14_w500(
                                        color: AppColor.cyanHighlight,
                                      ),
                                    );
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: AppColor.secondarytextColor,
                                        size: 28.sp,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        'Click here to upload',
                                        style: AppTextStyles.title12_w400(
                                          color: AppColor.secondarytextColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Submit Now Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: controller.onSubmitNow,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Submit Now',
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
