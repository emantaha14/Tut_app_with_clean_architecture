import 'dart:async';

import 'package:app_with_clean_architecture/app/app_prefs.dart';
import 'package:app_with_clean_architecture/presentation/resources/assets_manager.dart';
import 'package:app_with_clean_architecture/presentation/resources/color_manager.dart';
import 'package:app_with_clean_architecture/presentation/resources/constants_manager.dart';
import 'package:app_with_clean_architecture/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';

class SplashView extends StatefulWidget {
  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    // _appPreferences.isUserIsLoggedIn().then((isUserIsLoggedIn) {
    //   if(isUserIsLoggedIn){
    //     Navigator.pushReplacementNamed(context, Routes.mainRoute);
    //   }
    //   else{
    _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) {
      if (isOnBoardingScreenViewed) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
    });
    // }
    // });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
