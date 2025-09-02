import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/shared_pref_keys.dart';
import 'package:gym_app/core/helpers/extensions.dart';
import 'package:gym_app/core/helpers/shared_pref_helper.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:gym_app/features/onboarding/presentation/widgets/dumbbell.dart';
import 'package:gym_app/main_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _characterController;

  late AnimationController _textController;
  late Animation<double> _textAnimation;

  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    _characterController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textController);

    Future.delayed(Duration(milliseconds: 500), () {
      _textController.forward();
    });

    // Glow animation for dumbbell
    _glowController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);

    // Optional: Navigate after some delay (uncomment and implement your navigation)
    Future.delayed(Duration(seconds: 5), () async {
      bool isLogged = await checkIfLoggedInUser();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => isLogged ? MainPage() : OnboardingPage()));
    });
  }

  @override
  void dispose() {
    _characterController.dispose();
    _textController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradient for more depth
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDumbbellWidget(size: 180),
              SizedBox(height: 40),
              FadeTransition(
                opacity: _textAnimation,
                child: AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    // Animate letter spacing from 3 to 10 and back
                    double letterSpacing =
                        3 + 7 * sin(_textController.value * pi);
                    return Text(
                      'Fit Pulse',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: letterSpacing,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: AppColors.primary.withOpacity(0.7),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

  return !userToken.isNullOrEmpty();
}
