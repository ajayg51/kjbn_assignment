import 'package:flutter/material.dart';
import 'package:kjbn_assignment/utils/assets.dart';


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
