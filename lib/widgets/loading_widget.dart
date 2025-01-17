import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';

class LoadingWidget extends StatelessWidget {
  final Size? size;
  LoadingWidget({super.key, this.size = const Size(300, 300)});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Center(
        child: LottieBuilder.asset(
          provider.themeMode == ThemeMode.light
              ? loadingAnimation
              : loadingAnimationSecond,
          animate: true,
          repeat: true,
          width: size!.width,
          height: size!.height,
          frameRate: const FrameRate(120),
        ),
      );
    });
  }
}
