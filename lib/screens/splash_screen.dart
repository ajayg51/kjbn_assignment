import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
