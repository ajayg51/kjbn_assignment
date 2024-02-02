import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kjbn_assignment/utils/assets.dart';
import 'package:kjbn_assignment/utils/common_appbar.dart';
import 'package:kjbn_assignment/utils/common_scaffold.dart';
import 'package:kjbn_assignment/utils/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Column(
        children: [
          const CommonAppbar(),
          12.verticalSpace,
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    sizeAnimation =
        Tween<double>(begin: 50, end: 600)
        .animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, __) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                ]
              )
            ),
            child: Image.asset(
              Assets.logo,
              width: sizeAnimation.value,
              height: sizeAnimation.value,
            ),
          ),
          12.verticalSpace,
          Text(
            "Catch me if you can!",
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 48,
            ),
          ),
        ],
      ),
    );
  }
}
