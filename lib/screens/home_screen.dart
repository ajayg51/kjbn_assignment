import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kjbn_assignment/utils/common_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Text(
        "Home screen",
        style: Get.textTheme.bodyLarge,
      ),
    );
  }
}
