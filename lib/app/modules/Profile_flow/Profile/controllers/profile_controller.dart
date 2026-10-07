import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final userName = 'Alex Johnson'.obs;
  final userEmail = 'alex.johnson@gmail.com'.obs;

  final vesselName = 'Salt Runner'.obs;
  final vesselLength = '24 ft'.obs;
  final enginePort = 'Single • 250hp'.obs;
  final homePort = 'St. Petersburg, FL'.obs;

  final emailNotificationEnabled = true.obs;
  final profileImagePath = RxnString();

  Future<void> pickProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not pick image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF132A3E),
        colorText: Colors.white,
      );
    }
  }

  void toggleEmailNotification(bool value) {
    emailNotificationEnabled.value = value;
  }

  void onVesselSetup() => Get.toNamed(Routes.VESSEL_SETUP);
  void onChangeLanguage() => Get.toNamed(Routes.CHANGE_LANGUAGE);
  void onSubscriptionPlan() => Get.toNamed(Routes.SUBSCRIPTION_PACKAGE);
  void onFaq() => Get.toNamed(Routes.FAQ);
  void onContactSupport() => Get.toNamed(Routes.CONTACT_SUPPORT);

  void onAboutNautiGo() {
    Get.to(() => const _AboutNautiGoScreen());
  }

  void onPrivacyPolicy() {
    Get.to(() => const _PrivacyPolicyScreen());
  }

  void onTermsAndService() {
    Get.to(() => const _TermsAndServiceScreen());
  }

  void onRateNautiGo() {
    Get.snackbar(
      'Rate NautiGo',
      'Thank you for rating NautiGo!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF132A3E),
      colorText: Colors.white,
    );
  }

  void onLogout() {
    Get.dialog(const _LogoutDialog());
  }

  void onDeleteAccount() {
    Get.dialog(const _DeleteAccountDialog());
  }
}

// ─── About NautiGO Screen ────────────────────────────────────────────────────
class _AboutNautiGoScreen extends StatelessWidget {
  const _AboutNautiGoScreen();

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
          'About NautiGO',
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
                Icon(Icons.anchor_rounded, color: Color(0xFF0AD5EC), size: 36),
                SizedBox(height: 14),
                Text(
                  'About NautiGO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'NautiGO AI is a next-generation marine navigation platform designed to help boaters navigate safer, smarter, and more efficiently on the water. Combining intelligent route planning, real-time hazard alerts, vessel-specific insights, fuel optimization, and community-powered reporting, NautiGO transforms traditional marine navigation into a connected and data-driven experience.\n\nWhether for recreational boating or professional marine operations, the platform provides reliable guidance through interactive nautical maps, AI-assisted recommendations, and live safety updates. Inspired by the concept of a "Waze of the Sea," NautiGO empowers boaters with the information they need to make confident decisions, avoid risks, and enjoy every journey with greater awareness and control.',
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

// ─── Terms & Service Screen ──────────────────────────────────────────────────
class _TermsAndServiceScreen extends StatelessWidget {
  const _TermsAndServiceScreen();

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
