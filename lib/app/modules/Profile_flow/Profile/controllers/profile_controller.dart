import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final userName = 'Captain Alex'.obs;
  final vesselName = 'Salt Runner'.obs;
  final userEmail = 'alex.johnson@gmail.com'.obs;

  void onVesselSetup() => Get.toNamed(Routes.VESSEL_SETUP);
  void onChangeLanguage() => Get.toNamed(Routes.CHANGE_LANGUAGE);
  void onSubscriptionPackage() => Get.toNamed(Routes.SUBSCRIPTION_PACKAGE);
  void onFaq() => Get.toNamed(Routes.FAQ);
  void onContactSupport() => Get.toNamed(Routes.CONTACT_SUPPORT);

  void onPrivacyPolicy() {
    Get.to(() => const _PrivacyPolicyScreen());
  }

  void onTermsAndPolicy() {
    Get.to(() => const _TermsAndPolicyScreen());
  }

  void onLogout() {
    Get.dialog(const _LogoutDialog());
  }

  void onDeleteAccount() {
    Get.dialog(const _DeleteAccountDialog());
  }
}

// ─── Privacy Policy Screen ───────────────────────────────────────────────────
class _PrivacyPolicyScreen extends StatelessWidget {
  const _PrivacyPolicyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF021B2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF132A3E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, color: Colors.white, size: 32),
                SizedBox(height: 14),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'At NautiGO AI, we value your privacy and are committed to protecting your personal information. We collect essential data such as account details, vessel information, location data, and navigation activity to provide route guidance, hazard alerts, fuel planning, and other marine navigation services.\n\nLocation access is required to enable real-time navigation, safety notifications, and community-powered reporting features.\n\nCommunity reports may be shared with other users to improve boating safety, but your personal information is not publicly displayed.\n\nWe do not sell your personal data. Information is only used to operate, improve, and secure the NautiGO AI platform.\n\nBy using NautiGO AI, you agree to the collection and use of information as described in this policy.',
                  style: TextStyle(
                    color: Color(0xFFBAC9CC),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Terms & Policy Screen ───────────────────────────────────────────────────
class _TermsAndPolicyScreen extends StatelessWidget {
  const _TermsAndPolicyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF021B2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Terms and Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF132A3E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, color: Colors.white, size: 32),
                SizedBox(height: 14),
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'By using NautiGO AI, you agree to use the platform responsibly and in accordance with all applicable laws and marine navigation regulations.\n\nNautiGO AI provides navigation assistance, route recommendations, hazard alerts, fuel planning tools, and community-generated information. While we strive to provide accurate and reliable data, users remain solely responsible for operating their vessels safely and making final navigation decisions.\n\nCommunity reports and alerts are provided by users and may not always be verified. Users should exercise caution and use their own judgment when relying on shared information.\n\nYou agree not to misuse the platform, submit false reports, interfere with services, or engage in activities that may compromise the safety of other users.\n\nNautiGO AI reserves the right to modify, suspend, or update features, policies, and services at any time. Continued use of the platform constitutes acceptance of these terms.\n\nBy accessing or using NautiGO AI, you acknowledge and agree to these Terms & Conditions.',
                  style: TextStyle(
                    color: Color(0xFFBAC9CC),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Logout Dialog ───────────────────────────────────────────────────────────
class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1B85FF), Color(0xFF0AD5EC)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to log out?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(Routes.LOGIN_OPTION);
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF1B85FF),
                            fontWeight: FontWeight.w600,
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
    );
  }
}

// ─── Delete Account Dialog ───────────────────────────────────────────────────
class _DeleteAccountDialog extends StatelessWidget {
  const _DeleteAccountDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFFF483D),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to delete your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(Routes.LOGIN_OPTION);
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFFFF483D),
                            fontWeight: FontWeight.w600,
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
    );
  }
}
