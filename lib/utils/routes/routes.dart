import 'package:eathut/screens/authentication/pages/create_new_password_screen/create_new_password_screen.dart';
import 'package:eathut/screens/authentication/pages/forget_password/forget_password_screen.dart';
import 'package:eathut/screens/authentication/pages/otp/otp_screen.dart';
import 'package:eathut/screens/core/pages/add_address/add_address.dart';
import 'package:eathut/screens/core/pages/cart/cart_screen.dart';
import 'package:eathut/screens/core/pages/category/category_screen.dart';
import 'package:eathut/screens/core/pages/food_details/food_details_screen.dart';
import 'package:eathut/screens/core/pages/home/home_screen.dart';
import 'package:eathut/screens/core/pages/restaurant_details/restaurant_details_screen.dart';
import 'package:eathut/screens/core/pages/search/search_screen.dart';
import 'package:eathut/screens/core/pages/search_results/search_results.dart';
import 'package:get/get.dart';

import '../../screens/authentication/pages/login/login_screen.dart';
import '../../screens/authentication/pages/onboarding/onboarding_screen.dart';
import '../../screens/authentication/pages/signup/signup_screen.dart';
import '../../screens/authentication/pages/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';
  static const String createNewPassword = '/createNewPassword';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String search = '/search';
  static const String category = '/category';
  static const String foodDetails = '/foodDetails';
  static const String restaurantDetails = '/restaurantDetails';
  static const String cart = '/cart';
  static const String addAddress = '/addAddress';
  static const String searchResults = '/searchResults';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: onBoarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: forgetPassword,
      page: () => const ForgetPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: createNewPassword,
      page: () => const CreateNewPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: otp,
      page: () => const OTPScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: search,
      page: () => const SearchScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: category,
      page: () => const CategoryScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: foodDetails,
      page: () => const FoodDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: restaurantDetails,
      page: () => const RestaurantDetailsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: cart,
      page: () => const CartScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: addAddress,
      page: () => const AddAddressScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: searchResults,
      page: () => const SearchResultScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
