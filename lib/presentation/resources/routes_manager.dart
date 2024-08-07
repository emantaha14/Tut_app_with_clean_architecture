import 'package:app_with_clean_architecture/app/di.dart';
import 'package:app_with_clean_architecture/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:app_with_clean_architecture/presentation/login/view/login_view.dart';
import 'package:app_with_clean_architecture/presentation/main/main_view.dart';
import 'package:app_with_clean_architecture/presentation/onboarding/view/onboarding_view.dart';
import 'package:app_with_clean_architecture/presentation/register/view/register_view.dart';
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
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
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
