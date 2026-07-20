import 'package:get/get.dart';

import '../modules/Auth/Login/bindings/login_binding.dart';
import '../modules/Auth/Login/views/login_view.dart';
import '../modules/Auth/Login_Option/bindings/login_option_binding.dart';
import '../modules/Auth/Login_Option/views/login_option_view.dart';
import '../modules/Auth/Login_otp/bindings/login_otp_binding.dart';
import '../modules/Auth/Login_otp/views/login_otp_view.dart';
import '../modules/Auth/SignUp/bindings/sign_up_binding.dart';
import '../modules/Auth/SignUp/views/sign_up_view.dart';
import '../modules/Auth/SignUp_otp/bindings/sign_up_otp_binding.dart';
import '../modules/Auth/SignUp_otp/views/sign_up_otp_view.dart';
import '../modules/Auth/Verifed/bindings/verifed_binding.dart';
import '../modules/Auth/Verifed/views/verifed_view.dart';
import '../modules/Profile_flow/Change_language/bindings/change_language_binding.dart';
import '../modules/Profile_flow/Change_language/views/change_language_view.dart';
import '../modules/Profile_flow/Contact_support/bindings/contact_support_binding.dart';
import '../modules/Profile_flow/Contact_support/views/contact_support_view.dart';
import '../modules/Profile_flow/FAQ/bindings/faq_binding.dart';
import '../modules/Profile_flow/FAQ/views/faq_view.dart';
import '../modules/Profile_flow/Profile/bindings/profile_binding.dart';
import '../modules/Profile_flow/Profile/views/profile_view.dart';
import '../modules/Profile_flow/Subscription_package/bindings/subscription_package_binding.dart';
import '../modules/Profile_flow/Subscription_package/views/subscription_package_view.dart';
import '../modules/Splash/bindings/splash_binding.dart';
import '../modules/Splash/views/splash_view.dart';
import '../modules/Vessel/EngineandFuel/bindings/engineand_fuel_binding.dart';
import '../modules/Vessel/EngineandFuel/views/engineand_fuel_view.dart';
import '../modules/Vessel/VesselDymensions/bindings/vessel_dymensions_binding.dart';
import '../modules/Vessel/VesselDymensions/views/vessel_dymensions_view.dart';
import '../modules/Vessel/VesselSetup/bindings/vessel_setup_binding.dart';
import '../modules/Vessel/VesselSetup/views/vessel_setup_view.dart';
import '../modules/main_screen/Cummunity_flow/Cummunity/bindings/cummunity_binding.dart';
import '../modules/main_screen/Cummunity_flow/Cummunity/views/cummunity_view.dart';
import '../modules/main_screen/Cummunity_flow/add_useful_places/bindings/add_useful_places_binding.dart';
import '../modules/main_screen/Cummunity_flow/add_useful_places/views/add_useful_places_view.dart';
import '../modules/main_screen/Fule_calculator/Fluel_planer/bindings/fluel_planer_binding.dart';
import '../modules/main_screen/Fule_calculator/Fluel_planer/views/fluel_planer_view.dart';
import '../modules/main_screen/Fule_calculator/Fluel_planer_result/bindings/fluel_planer_result_binding.dart';
import '../modules/main_screen/Fule_calculator/Fluel_planer_result/views/fluel_planer_result_view.dart';
import '../modules/main_screen/Home_flow/Home/bindings/home_binding.dart';
import '../modules/main_screen/Home_flow/Home/views/home_view.dart';
import '../modules/main_screen/Home_flow/Plan_a_route/bindings/plan_a_route_binding.dart';
import '../modules/main_screen/Home_flow/Plan_a_route/views/plan_a_route_view.dart';
import '../modules/main_screen/Home_flow/Suggested_route/bindings/suggested_route_binding.dart';
import '../modules/main_screen/Home_flow/Suggested_route/views/suggested_route_view.dart';
import '../modules/main_screen/Main_navber/bindings/main_navber_binding.dart';
import '../modules/main_screen/Main_navber/views/main_navber_view.dart';
import '../modules/main_screen/Report_flow/Confirm_Locaiton/bindings/confirm_locaiton_binding.dart';
import '../modules/main_screen/Report_flow/Confirm_Locaiton/views/confirm_locaiton_view.dart';
import '../modules/main_screen/Report_flow/Report/bindings/report_binding.dart';
import '../modules/main_screen/Report_flow/Report/views/report_view.dart';
import '../modules/main_screen/Report_flow/Submite_Locaiton/bindings/submite_locaiton_binding.dart';
import '../modules/main_screen/Report_flow/Submite_Locaiton/views/submite_locaiton_view.dart';
import '../modules/main_screen/Home_flow/Notification/bindings/notification_binding.dart';
import '../modules/main_screen/Home_flow/Notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_OPTION,
      page: () => const LoginOptionView(),
      binding: LoginOptionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_OTP,
      page: () => const LoginOtpView(),
      binding: LoginOtpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_OTP,
      page: () => const SignUpOtpView(),
      binding: SignUpOtpBinding(),
    ),
    GetPage(
      name: _Paths.VERIFED,
      page: () => const VerifedView(),
      binding: VerifedBinding(),
    ),
    GetPage(
      name: _Paths.VESSEL_SETUP,
      page: () => const VesselSetupView(),
      binding: VesselSetupBinding(),
    ),
    GetPage(
      name: _Paths.ENGINEAND_FUEL,
      page: () => const EngineandFuelView(),
      binding: EngineandFuelBinding(),
    ),
    GetPage(
      name: _Paths.VESSEL_DYMENSIONS,
      page: () => const VesselDymensionsView(),
      binding: VesselDymensionsBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVBER,
      page: () => const MainNavberView(),
      binding: MainNavberBinding(),
    ),
    GetPage(
      name: _Paths.SUGGESTED_ROUTE,
      page: () => const SuggestedRouteView(),
      binding: SuggestedRouteBinding(),
      children: [
        GetPage(
          name: _Paths.SUGGESTED_ROUTE,
          page: () => const SuggestedRouteView(),
          binding: SuggestedRouteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PLAN_A_ROUTE,
      page: () => const PlanARouteView(),
      binding: PlanARouteBinding(),
    ),
    GetPage(
      name: _Paths.FLUEL_PLANER,
      page: () => const FluelPlanerView(),
      binding: FluelPlanerBinding(),
    ),
    GetPage(
      name: _Paths.FLUEL_PLANER_RESULT,
      page: () => const FluelPlanerResultView(),
      binding: FluelPlanerResultBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_LOCAITON,
      page: () => const ConfirmLocaitonView(),
      binding: ConfirmLocaitonBinding(),
    ),
    GetPage(
      name: _Paths.SUBMITE_LOCAITON,
      page: () => const SubmiteLocaitonView(),
      binding: SubmiteLocaitonBinding(),
    ),
    GetPage(
      name: _Paths.CUMMUNITY,
      page: () => const CummunityView(),
      binding: CummunityBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USEFUL_PLACES,
      page: () => const AddUsefulPlacesView(),
      binding: AddUsefulPlacesBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_SUPPORT,
      page: () => const ContactSupportView(),
      binding: ContactSupportBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_PACKAGE,
      page: () => const SubscriptionPackageView(),
      binding: SubscriptionPackageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
