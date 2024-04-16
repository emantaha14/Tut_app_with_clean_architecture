import 'package:app_with_clean_architecture/presentation/forgot_password/forgot_password.dart';
import 'package:app_with_clean_architecture/presentation/login/login_view.dart';
import 'package:app_with_clean_architecture/presentation/main/main_view.dart';
import 'package:app_with_clean_architecture/presentation/onboarding/onboarding_view.dart';
import 'package:app_with_clean_architecture/presentation/register/register_view.dart';
import 'package:app_with_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:app_with_clean_architecture/presentation/splash/splash_view.dart';
import 'package:app_with_clean_architecture/presentation/store_details/store_details.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
  static const String onBoardingRoute = '/onBoarding';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) =>  SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      default: 
        return unDefinedRoute();
    }
  }
  
  static Route<dynamic>unDefinedRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(title: const Text(AppStrings.noRouteFound),),
      body: const Center(child: Text(AppStrings.noRouteFound),),
    ),);
  }
}
