import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../controllers/cummunity_controller.dart';

class CummunityView extends GetView<CummunityController> {
  const CummunityView({super.key});

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

              // Dynamic Title Header
              Obx(() => Text(
                    controller.selectedTab.value,
                    style: AppTextStyles.title22_w600(color: Colors.white),
                  )),
              SizedBox(height: 16.h),

              // Top Stats Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    _TopStatItem(
                      value: controller.activeNearby.value.toString(),
                      label: 'Active Nearby',
                    ),
                    SizedBox(width: 8.w),
                    _TopStatItem(
                      value: controller.hazardsToday.value.toString(),
                      label: 'Hazards Today',
                    ),
                    SizedBox(width: 8.w),
                    _TopStatItem(
                      value: controller.confirmations.value.toString(),
                      label: 'Confirmation',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Sub-Navigation Tabs Bar
              Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.tabs.map((tab) {
                        final isSelected =
                            controller.selectedTab.value == tab;
                        return GestureDetector(
                          onTap: () => controller.selectTab(tab),
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? AppColor.brandLinearGradient
                                  : null,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Text(
                              tab,
                              style: AppTextStyles.title14_w500(
                                color: isSelected
                                    ? Colors.white
                                    : AppColor.secondarytextColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
              SizedBox(height: 20.h),

              // Tab Content Area
              Obx(() {
                if (controller.selectedTab.value == 'My Reports') {
                  return _buildMyReportsContent();
                } else {
                  return _buildUsefulPlacesContent();
                }
              }),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ─── My Reports Tab Content ───────────────────────────────────────────────
  Widget _buildMyReportsContent() {
    return Column(
      children: [
        // Card 1: Fishing Net
        _CommunityCard(
          title: 'Fishing Net',
          badgeText: 'High',
          badgeIsHigh: true,
          sub1: '0.6 NM from entry point',
          sub2: 'Reported by community',
          btnLeftText: 'Edit Report',
          btnRightText: 'Withdraw',
          onRightTap: () {},
        ),
        SizedBox(height: 16.h),

        // Card 2: Fuel dock available
        _CommunityCard(
          title: 'Fuel dock available',
          badgeText: 'Open',
          badgeIsOpen: true,
          sub1: '0.6 NM from entry point',
          sub2: 'Reported 12 min',
          btnLeftText: 'Edit Places',
          btnRightText: 'Withdraw',
          onRightTap: () {},
        ),
        SizedBox(height: 32.h),

        // Bottom Fixed Buttons: Add a Report & Add Useful Places
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: controller.onAddReport,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECEB),
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Add a Report',
                      style: AppTextStyles.title16_w600(
                        color: const Color(0xFFFF483D),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: controller.onAddUsefulPlaces,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: AppColor.brandLinearGradient,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: Center(
                    child: Text(
                      'Add Useful Places',
                      style: AppTextStyles.title16_w600(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Useful Places Tab Content ────────────────────────────────────────────
  Widget _buildUsefulPlacesContent() {
    return Column(
      children: [
        // Card 1
        _CommunityCard(
          title: 'Fuel dock available',
          badgeText: 'Open',
          badgeIsOpen: true,
          sub1: '2.4 NM away',
          sub2: 'Reported by community',
          btnLeftText: 'Confirm Open',
          btnRightText: 'Navigate',
          onRightTap: controller.onNavigate,
        ),
        SizedBox(height: 16.h),

        // Card 2
        _CommunityCard(
          title: 'Fuel dock available',
          badgeText: 'Open',
          badgeIsOpen: true,
          sub1: '2.4 NM away',
          sub2: 'Reported by community',
          btnLeftText: 'Confirm Open',
          btnRightText: 'Navigate',
          onRightTap: controller.onNavigate,
        ),
        SizedBox(height: 32.h),

        // Bottom Action Button: Add Useful Places
        GestureDetector(
          onTap: controller.onAddUsefulPlaces,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              gradient: AppColor.brandLinearGradient,
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Center(
              child: Text(
                'Add Useful Places',
                style: AppTextStyles.title16_w600(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Top Stat Item Widget ───────────────────────────────────────────────────
class _TopStatItem extends StatelessWidget {
  final String value;
  final String label;

  const _TopStatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0F2639),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.title18_w600(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTextStyles.title10_w500(
                color: AppColor.secondarytextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Community Card Widget ──────────────────────────────────────────────────
class _CommunityCard extends StatelessWidget {
  final String title;
  final String badgeText;
  final bool badgeIsHigh;
  final bool badgeIsOpen;
  final String sub1;
  final String sub2;
  final String btnLeftText;
  final String btnRightText;
  final VoidCallback onRightTap;

  const _CommunityCard({
    required this.title,
    required this.badgeText,
    this.badgeIsHigh = false,
    this.badgeIsOpen = false,
    required this.sub1,
    required this.sub2,
    required this.btnLeftText,
    required this.btnRightText,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
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
          // Title & Badge Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.title18_w600(color: Colors.white),
              ),
              if (badgeIsHigh)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECEB),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    badgeText,
                    style: AppTextStyles.title12_w500(
                      color: const Color(0xFFFF483D),
                    ),
                  ),
                )
              else if (badgeIsOpen)
                Text(
                  badgeText,
                  style: AppTextStyles.title16_w600(
                    color: const Color(0xFF1B85FF),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            sub1,
            style: AppTextStyles.title14_w400(
              color: AppColor.secondarytextColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            sub2,
            style: AppTextStyles.title14_w400(
              color: AppColor.secondarytextColor,
            ),
          ),
          SizedBox(height: 14.h),

          // Inner Dark Radar Box
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0F2639),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Radar Thumbnail
                    Container(
                      width: 90.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF021B2D),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: CustomPaint(
                        painter: _RadarThumbnailPainter(),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reliability',
                                style: AppTextStyles.title14_w400(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '88%',
                                style: AppTextStyles.title14_w500(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          // Green progress line
                          Stack(
                            children: [
                              Container(
                                height: 6.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.88,
                                child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00D8B1),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '12 Mariner Confirmations',
                            style: AppTextStyles.title12_w400(
                              color: AppColor.secondarytextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),

                // Card Action Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            btnLeftText,
                            style: AppTextStyles.title14_w500(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: onRightTap,
                        child: Container(
                          height: 42.h,
                          decoration: BoxDecoration(
                            gradient: AppColor.brandLinearGradient,
                            borderRadius: BorderRadius.circular(21.r),
                          ),
                          child: Center(
                            child: Text(
                              btnRightText,
                              style: AppTextStyles.title14_w500(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Radar Thumbnail Painter ────────────────────────────────────────────────
class _RadarThumbnailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.3, size.height * 0.7);
    final circlePaint = Paint()
      ..color = const Color(0xFF0AD5EC).withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, 12.r, circlePaint);
    canvas.drawCircle(center, 22.r, circlePaint);
    canvas.drawCircle(center, 32.r, circlePaint);

    // Ship position cyan triangle
    final shipPaint = Paint()..color = const Color(0xFF0AD5EC);
    final path = Path()
      ..moveTo(center.dx, center.dy - 5)
      ..lineTo(center.dx - 4, center.dy + 4)
      ..lineTo(center.dx + 4, center.dy + 4)
      ..close();
    canvas.drawPath(path, shipPaint);

    // Dashed line to target red dot
    final targetPoint = Offset(size.width * 0.7, size.height * 0.25);
    final linePaint = Paint()
      ..color = const Color(0xFF0AD5EC).withValues(alpha: 0.6)
      ..strokeWidth = 1.0;
    canvas.drawLine(center, targetPoint, linePaint);

    // Target red dot
    final redDotPaint = Paint()..color = const Color(0xFFFF5252);
    canvas.drawCircle(targetPoint, 4.r, redDotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
