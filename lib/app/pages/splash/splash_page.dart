import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/splash/splash_controller.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';

import '../../images/svg/svg_images.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) => Transform.scale(
                  scale: controller.scaleAnimation.value +
                      (controller.reverseScaleAnimation.value * 0.9),
                  child: Opacity(
                    opacity: controller.opacityAnimation.value,
                    child: child,
                  ),
                ),
                child: SvgPicture.asset(SvgImages.icLogo),
              ),
            ],
          ),
        ),
      );
}
