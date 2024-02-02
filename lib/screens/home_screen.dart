import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kjbn_assignment/screens/home_screen_controller.dart';
import 'package:kjbn_assignment/utils/color_consts.dart';
import 'package:kjbn_assignment/utils/common_appbar.dart';
import 'package:kjbn_assignment/utils/common_scaffold.dart';
import 'package:kjbn_assignment/utils/extensions.dart';
import 'package:kjbn_assignment/utils/separator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeScreenController());

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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildCounterRow.padSymmetric(horizontalPad: 12),
                        48.verticalSpace,
                        Obx(
                          () {
                            final attemptCount = controller.attemptCount.value;
                            final isSuccess = controller.isSuccess.value;
                            final isTimeup = controller.isTimeup.value;

                            final secLeft = controller.timerSecond.value;

                            // case failure
                            String label = "Sorry try again!";
                            String info = "Attempts : $attemptCount";
                            int colorValue = ColorConsts.orange;

                            // case success
                            if (isSuccess) {
                              label = "Success :)";
                              info = "Score : 1/$attemptCount";
                              colorValue = ColorConsts.green;
                            }
                            // case timeup
                            else if (isTimeup) {
                              label = "Failure :(";
                              colorValue = ColorConsts.red;
                            }

                            return Column(
                              children: [
                                buildResultInfo(
                                  label: label,
                                  info: info,
                                  colorValue: colorValue,
                                ).padSymmetric(horizontalPad: 12),
                                48.verticalSpace,
                                buildTimer(secLeft: secLeft),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                buildPlayBtn().padSymmetric(horizontalPad: 12),
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
          child: Obx(
            () {
              final curSec = controller.currentSecond.value;
              return buildTileInfo(
                colorValue: ColorConsts.skyBlue,
                label: "Current second",
                info: curSec.toString(),
              );
            },
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Obx(() {
            final randVal = controller.randomValue.value;
            return buildTileInfo(
              colorValue: ColorConsts.purple,
              label: "Random Number",
              info: randVal.toString(),
            );
          }),
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

  Widget buildTimer({
    required int secLeft,
  }) {
    Color color = Colors.green;
    if (secLeft < 5 && secLeft >= 3) {
      color = Colors.yellow;
    } else if (secLeft < 3 && secLeft >= 0) {
      color = Colors.red;
    }

    return Stack(
      children: [
        buildTimerContainer(color: color),
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
                      text: secLeft.toString(),
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

  Widget buildPlayBtn() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: controller.onBtnTap,
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
