import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class FaqItemModel {
  final String question;
  final String answer;

  FaqItemModel({required this.question, required this.answer});
}

class FaqController extends GetxController {
  final expandedIndex = 0.obs; // First item expanded by default as shown in design

  final faqs = <FaqItemModel>[
    FaqItemModel(
      question: 'What is CrewNest?',
      answer:
          'CrewNest is a trusted accommodation marketplace exclusively for verified airline staff, including cabin crew, pilots, and ground staff.',
    ),
    FaqItemModel(
      question: 'Who can join NautiGo?',
      answer:
          'NautiGo is open to all mariners, boat owners, captains, and maritime enthusiasts.',
    ),
    FaqItemModel(
      question: 'Why do I need to verify my work email?',
      answer:
          'Verifying your email ensures community trust, security, and access to verified features.',
    ),
    FaqItemModel(
      question: 'Can I log in using my work email?',
      answer:
          'Yes, you can register and log in using any valid work or personal email address.',
    ),
    FaqItemModel(
      question: 'My airline is not listed. What should I do?',
      answer:
          'You can contact support to request adding your organization or airline.',
    ),
    FaqItemModel(
      question: 'How do I book a property?',
      answer:
          'Browse listings, select your desired dates, and proceed with instant booking confirmation.',
    ),
    FaqItemModel(
      question: 'Can I see the exact property address before booking?',
      answer:
          'Approximate locations are displayed for privacy; exact addresses are shared upon booking.',
    ),
  ];

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // collapse
    } else {
      expandedIndex.value = index; // expand
    }
  }

  void onNeedSupport() {
    Get.toNamed(Routes.CONTACT_SUPPORT);
  }
}
