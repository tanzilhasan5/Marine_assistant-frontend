import 'package:shared_preferences/shared_preferences.dart';


class AppConstants {
    // Auth Keys
    static const String bearerToken  = 'bearer_token';
    static const String refreshToken = 'refresh_token';
    static const String isLoggedIn   = 'is_logged_in';
    static const String userRole     = 'role';
    static const String googleServerClientId = 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com';

    // User Data Keys
    static const String userData             = 'user_data';
    static const String userId               = 'user_id';
    static const String userName             = 'user_name';
    static const String userLastName         = 'user_last_name';
    static const String userEmail            = 'user_email';
    static const String userPhone            = 'user_phone';
    static const String userSubscription     = 'user_subscription';
    static const String userIsPro            = 'user_is_pro';

    static Future<void> clearUserData() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(bearerToken);
        await prefs.remove(refreshToken);
        await prefs.remove(isLoggedIn);
        await prefs.remove(userData);
        await prefs.remove(userId);
        await prefs.remove(userName);
        await prefs.remove(userLastName);
        await prefs.remove(userEmail);
        await prefs.remove(userPhone);
        await prefs.remove(userSubscription);
        await prefs.remove(userIsPro);
        await prefs.remove('role');
        await prefs.remove('transport_profile_image');
        await prefs.remove('transport_wallet_balance');
    }

}