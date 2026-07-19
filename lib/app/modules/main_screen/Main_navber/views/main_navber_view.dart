import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controllers/main_navber_controller.dart';

class MainNavberView extends GetView<MainNavberController> {
  const MainNavberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      // This Obx is fine as-is -> it only swaps the page, not the nav bar.
      body: Obx(() => controller.pages[controller.currentIndex.value]),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.07),
              width: 0.8,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 68.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _NavItem(
                    imagePath: Images.home,
                    label: 'Home',
                    index: 0,
                    controller: controller,
                  ),
                  _NavItem(
                    imagePath: Images.route,
                    label: 'Route',
                    index: 1,
                    controller: controller,
                  ),
                  _NavItem(
                    imagePath: Images.fuelPlanner,
                    label: 'Fuel',
                    index: 2,
                    controller: controller,
                  ),
                  _NavItem(
                    imagePath: Images.community,
                    label: 'Community',
                    index: 3,
                    controller: controller,
                  ),
                  _NavItem(
                    imagePath: Images.person,
                    label: 'Profile',
                    index: 4,
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final int index;
  final MainNavberController controller;

  const _NavItem({
    required this.imagePath,
    required this.label,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changePage(index),
        child: Obx(() {
          final isSelected = index == controller.currentIndex.value;

          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: isSelected ? -28.h : 8.h,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: isSelected ? 60.w : 40.w,
                  height: isSelected ? 60.w : 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected
                        ? AppColor.brandLinearGradient
                        : null,
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      width: isSelected ? 28.w : 20.w,
                      height: isSelected ? 28.h : 20.h,
                      color: isSelected
                          ? Colors.white
                          : AppColor.secondarytextColor,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 8.h,
                child: Text(
                  label,
                  style: AppTextStyles.title10_w500(
                    color: isSelected
                        ? Colors.white
                        : AppColor.secondarytextColor,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}