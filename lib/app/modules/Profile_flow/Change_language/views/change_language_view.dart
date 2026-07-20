import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  const ChangeLanguageView({super.key});

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
          'Change Language',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.languages.length,
                separatorBuilder: (context, index) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final lang = controller.languages[index];

                  return Obx(() {
                    final isSelected =
                        controller.selectedLanguage.value == lang;

                    return GestureDetector(
                      onTap: () => controller.selectLanguage(lang),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 56.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? AppColor.brandLinearGradient
                              : null,
                          color: isSelected
                              ? null
                              : AppColor.cardBackground,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            lang,
                            style: AppTextStyles.title16_w500(
                              color: Colors.white,
                            ),
                          ),
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
    );
  }
}
