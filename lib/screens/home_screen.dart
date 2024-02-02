import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kjbn_assignment/utils/color_consts.dart';
import 'package:kjbn_assignment/utils/common_appbar.dart';
import 'package:kjbn_assignment/utils/common_scaffold.dart';
import 'package:kjbn_assignment/utils/extensions.dart';
import 'package:kjbn_assignment/utils/separator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Column(
        children: [
          const CommonAppbar(),
          36.verticalSpace,
          Expanded(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildCounterRow.padSymmetric(horizontalPad: 12),
                      48.verticalSpace,
                      buildResultInfo(
                        label: "Sorry try again!",
                        info: "Attempts : 1 ",
                        colorValue: ColorConsts.orange,
                      ).padSymmetric(horizontalPad: 12),
                      48.verticalSpace,
                      buildTimer,
                    ],
                  ),
                ),
                const Spacer(),
                buildBtn.padSymmetric(horizontalPad: 12),
                24.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get buildCounterRow {
    return Row(
      children: [
        Expanded(
          child: buildTileInfo(
            colorValue: ColorConsts.skyBlue,
            label: "Current second",
            info: "value",
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: buildTileInfo(
            colorValue: ColorConsts.purple,
            label: "Random Number",
            info: "value",
          ),
        ),
      ],
    );
  }

  Widget buildResultInfo({
    required String label,
    required String info,
    required int colorValue,
  }) {
    return Row(
      children: [
        Expanded(
          child: buildTileInfo(
            colorValue: colorValue,
            label: label,
            info: info,
          ),
        ),
      ],
    );
  }

  Widget buildTileInfo({
    required String label,
    required String info,
    required int colorValue,
  }) {
    return buildCommonTile(
      color: Color(colorValue),
      child: Column(
        children: [
          Text(
            label,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          6.verticalSpace,
          const Separator(),
          6.verticalSpace,
          Text(
            info,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommonTile({
    required Widget child,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: child).padSymmetric(verticalPad: 24),
    );
  }

  Widget get buildTimer {
    return Stack(
      children: [
        buildTimerContainer(
          color: Colors.green,
        ),
        Positioned(
          left: 10,
          top: 10,
          right: 10,
          bottom: 10,
          child: buildTimerContainer(
            color: const Color(0xff334257),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "5",
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontSize: 36,
                      ),
                    ),
                    TextSpan(
                      text: " s",
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimerContainer({
    double? width,
    double? height,
    Widget? child,
    required Color color,
  }) {
    return Container(
      width: width ?? 150,
      height: height ?? 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: child,
    );
  }

  Widget get buildBtn {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  "Chase!",
                  style: Get.textTheme.bodyLarge?.copyWith(fontSize: 36),
                ).padAll(value: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
