import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
          'Porfile',
          style: AppTextStyles.title20_w600(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar & User Info
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: controller.pickProfileImage,
                      behavior: HitTestBehavior.opaque,
                      child: Stack(
                        children: [
                          Obx(() {
                            final path = controller.profileImagePath.value;
                            return Container(
                              width: 86.w,
                              height: 86.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: path != null && path.isNotEmpty
                                      ? FileImage(File(path)) as ImageProvider
                                      : AssetImage(Images.person),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 26.w,
                              height: 26.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF132A3E),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(() => Text(
                          controller.userName.value,
                          style: AppTextStyles.title22_w600(color: Colors.white),
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
              ),
              SizedBox(height: 24.h),

              // ─── Section 1: Vessel Info ───────────────────────────────────
              Text(
                'Vessel Info',
                style: AppTextStyles.title18_w600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Obx(() => _InfoRow(
                          label: 'Vessel Name',
                          value: controller.vesselName.value,
                        )),
                    SizedBox(height: 10.h),
                    Obx(() => _InfoRow(
                          label: 'Length',
                          value: controller.vesselLength.value,
                        )),
                    SizedBox(height: 10.h),
                    Obx(() => _InfoRow(
                          label: 'Engine port',
                          value: controller.enginePort.value,
                        )),
                    SizedBox(height: 10.h),
                    Obx(() => _InfoRow(
                          label: 'Home port',
                          value: controller.homePort.value,
                        )),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: controller.onVesselSetup,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 44.h,
                        decoration: BoxDecoration(
                          gradient: AppColor.brandLinearGradient,
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Vessel',
                            style: AppTextStyles.title14_w500(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // ─── Section 2: Account ─────────────────────────────────────────
              Text(
                'Account',
                style: AppTextStyles.title18_w600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              _GroupCard(
                children: [
                  _GroupMenuItem(
                    icon: Icons.language_rounded,
                    title: 'Change Language',
                    onTap: controller.onChangeLanguage,
                  ),
                  const _GroupDivider(),
                  _GroupMenuItem(
                    icon: Icons.workspace_premium_outlined,
                    title: 'Subscription Plan',
                    onTap: controller.onSubscriptionPlan,
                  ),
                  const _GroupDivider(),
                  Obx(() => _GroupMenuItem(
                        icon: Icons.notifications_none_rounded,
                        title: 'Received Notification Via Email',
                        showChevron: false,
                        trailing: SizedBox(
                          height: 24.h,
                          child: Switch(
                            value: controller.emailNotificationEnabled.value,
                            onChanged: controller.toggleEmailNotification,
                            activeThumbColor: const Color(0xFF0AD5EC),
                            activeTrackColor:
                                const Color(0xFF0AD5EC).withValues(alpha: 0.3),
                            inactiveTrackColor: const Color(0xFF0F2639),
                          ),
                        ),
                        onTap: () => controller.toggleEmailNotification(
                          !controller.emailNotificationEnabled.value,
                        ),
                      )),
                ],
              ),
              SizedBox(height: 20.h),

              // ─── Section 3: Support ─────────────────────────────────────────
              Text(
                'Support',
                style: AppTextStyles.title18_w600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              _GroupCard(
                children: [
                  _GroupMenuItem(
                    icon: Icons.format_list_bulleted_rounded,
                    title: 'FAQ',
                    onTap: controller.onFaq,
                  ),
                  const _GroupDivider(),
                  _GroupMenuItem(
                    icon: Icons.headset_mic_outlined,
                    title: 'Contac Support',
                    onTap: controller.onContactSupport,
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // ─── Section 4: Legal ───────────────────────────────────────────
              Text(
                'Legal',
                style: AppTextStyles.title18_w600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              _GroupCard(
                children: [
                  _GroupMenuItem(
                    icon: Icons.anchor_rounded,
                    title: 'About NautiGO',
                    onTap: controller.onAboutNautiGo,
                  ),
                  const _GroupDivider(),
                  _GroupMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: controller.onPrivacyPolicy,
                  ),
                  const _GroupDivider(),
                  _GroupMenuItem(
                    icon: Icons.article_outlined,
                    title: 'Terms & Service',
                    onTap: controller.onTermsAndService,
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // ─── Section 5: App ─────────────────────────────────────────────
              Text(
                'App',
                style: AppTextStyles.title18_w600(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              _GroupCard(
                children: [
                  _GroupMenuItem(
                    icon: Icons.star_outline_rounded,
                    title: 'Rate NautiGo',
                    onTap: controller.onRateNautiGo,
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // ─── Action Buttons: Log Out & Delete Account ───────────────────
              GestureDetector(
                onTap: controller.onLogout,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(27.r),
                  ),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              GestureDetector(
                onTap: controller.onDeleteAccount,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF281824),
                    borderRadius: BorderRadius.circular(27.r),
                    border: Border.all(
                      color: const Color(0xFFFF483D).withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Delete Account',
                      style: AppTextStyles.title16_w600(
                        color: const Color(0xFFFF483D),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Footer Note
              Center(
                child: Text(
                  'Deleting your account is permanent. All your data\nand generations will be removed forever.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title12_w400(
                    color: AppColor.secondarytextColor,
                  ),
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

// ─── Info Row Widget ────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.title14_w400(
            color: AppColor.secondarytextColor,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.title14_w400(color: Colors.white),
        ),
      ],
    );
  }
}

// ─── Group Card Container Widget ────────────────────────────────────────────
class _GroupCard extends StatelessWidget {
  final List<Widget> children;

  const _GroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(children: children),
    );
  }
}

// ─── Group Divider Widget ───────────────────────────────────────────────────
class _GroupDivider extends StatelessWidget {
  const _GroupDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.06),
      indent: 16.w,
      endIndent: 16.w,
    );
  }
}

// ─── Group Menu Item Widget ─────────────────────────────────────────────────
class _GroupMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showChevron;
  final Widget? trailing;

  const _GroupMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.showChevron = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: AppColor.secondarytextColor, size: 22.sp),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.title14_w400(color: Colors.white),
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showChevron)
              Icon(
                Icons.chevron_right_rounded,
                color: AppColor.secondarytextColor,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
