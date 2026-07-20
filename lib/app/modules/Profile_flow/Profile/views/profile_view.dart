import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
                'Profile',
                style: AppTextStyles.title22_w600(color: Colors.white),
              ),
              SizedBox(height: 20.h),

              // Profile User Header Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: const BoxDecoration(
                        gradient: AppColor.brandLinearGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              controller.userName.value,
                              style: AppTextStyles.title18_w600(
                                  color: Colors.white),
                            )),
                        SizedBox(height: 2.h),
                        Obx(() => Text(
                              controller.userEmail.value,
                              style: AppTextStyles.title14_w400(
                                color: AppColor.secondarytextColor,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Profile Quick Actions Menu
              _ProfileMenuItem(
                icon: Icons.directions_boat_outlined,
                title: 'Vessel Setup',
                onTap: controller.onVesselSetup,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.language_rounded,
                title: 'Change Language',
                onTap: controller.onChangeLanguage,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.card_membership_outlined,
                title: 'Subscription Package',
                onTap: controller.onSubscriptionPackage,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: controller.onPrivacyPolicy,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.gavel_outlined,
                title: 'Terms and Policy',
                onTap: controller.onTermsAndPolicy,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.help_outline_rounded,
                title: 'FAQ',
                onTap: controller.onFaq,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.headset_mic_outlined,
                title: 'Contact Support',
                onTap: controller.onContactSupport,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.logout_rounded,
                title: 'Log Out',
                onTap: controller.onLogout,
              ),
              SizedBox(height: 10.h),
              _ProfileMenuItem(
                icon: Icons.delete_outline_rounded,
                title: 'Delete Account',
                onTap: controller.onDeleteAccount,
                iconColor: const Color(0xFFFF483D),
                textColor: const Color(0xFFFF483D),
              ),
              SizedBox(height: 24.h),

              // ─── About NautiGo Section ─────────────────────────────────────
              Text(
                'About NautiGo',
                style: AppTextStyles.title20_w600(color: Colors.white),
              ),
              SizedBox(height: 12.h),

              // About NautiGo Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.anchor_rounded,
                      color: AppColor.cyanHighlight,
                      size: 36.sp,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'NautiGO AI is a next-generation marine navigation platform designed to help boaters navigate safer, smarter, and more efficiently on the water. Combining intelligent route planning, real-time hazard alerts, vessel-specific insights, fuel optimization, and community-powered reporting, NautiGO transforms traditional marine navigation into a connected and data-driven experience.\n\nWhether for recreational boating or professional marine operations, the platform provides reliable guidance through interactive nautical maps, AI-assisted recommendations, and live safety updates. Inspired by the concept of a "Waze of the Sea," NautiGO empowers boaters with the information they need to make confident decisions, avoid risks, and enjoy every journey with greater awareness and control.',
                      style: AppTextStyles.title14_w400(
                        color: AppColor.secondarytextColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Profile Menu Item Widget ───────────────────────────────────────────────
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColor.cyanHighlight, size: 22.sp),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.title16_w500(
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColor.secondarytextColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
