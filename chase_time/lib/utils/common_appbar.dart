import 'package:chase_time/utils/assets.dart';
import 'package:flutter/material.dart';


class CommonAppbar extends StatelessWidget {
  const CommonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.banner,
      fit: BoxFit.contain,
    );
  }
}
