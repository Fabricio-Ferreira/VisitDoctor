import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_enum.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _reverseScaleAnimation;

  @override
  void onInit() {
    _initializeApp();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
      reverseDuration: const Duration(milliseconds: 1300),
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.8, curve: Curves.easeInOut),
    ));
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    _reverseScaleAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1, curve: Curves.easeInOut),
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
    super.onInit();
  }

  AnimationController get animationController => _animationController;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get opacityAnimation => _opacityAnimation;
  Animation<double> get reverseScaleAnimation => _reverseScaleAnimation;

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      _animationController.dispose();
      await Get.offAllNamed(Routes.main.path);
    });
  }
}
