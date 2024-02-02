import 'package:chase_time/screens/home_screen_controller.dart';
import 'package:chase_time/utils/color_consts.dart';
import 'package:chase_time/utils/common_appbar.dart';
import 'package:chase_time/utils/common_scaffold.dart';
import 'package:chase_time/utils/extensions.dart';
import 'package:chase_time/utils/separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                            final successCount = controller.successCount.value;
                            final failureCount = controller.failureCount.value;
                            final attemptCount = controller.attemptCount.value;

                            final isSuccess = controller.isSuccess.value;
                            final isTimeup = controller.isTimeup.value;
                            final secLeft = controller.timerSecond.value;

                            const tryAgainLabel = "Let's chase time in second";
                            final tryAgaininfo = "Attempts : $attemptCount";
                            const tryAgainColorValue = ColorConsts.orange;

                            const successLabel = "Success :)";
                            final successInfo =
                                "Score : $successCount/$attemptCount";
                            const successColorValue = ColorConsts.green;

                            const failureLabel = "Failure :(";
                            final failureInfo =
                                "Score : $failureCount/$attemptCount";
                            const failureColorValue = ColorConsts.red;

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    if (isSuccess || isTimeup) ...[
                                      Expanded(
                                        child: buildResultInfo(
                                          label: failureLabel,
                                          info: failureInfo,
                                          colorValue: failureColorValue,
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      Expanded(
                                        child: buildResultInfo(
                                          label: successLabel,
                                          info: successInfo,
                                          colorValue: successColorValue,
                                        ),
                                      ),
                                    ] else ...[
                                      Expanded(
                                        child: buildResultInfo(
                                          label: tryAgainLabel,
                                          info: tryAgaininfo,
                                          colorValue: tryAgainColorValue,
                                        ),
                                      ),
                                    ]
                                  ],
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
    return buildTileInfo(
      colorValue: colorValue,
      label: label,
      info: info,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          6.verticalSpace,
          const Separator(),
          6.verticalSpace,
          Text(
            info,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
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
    if (secLeft < 0) {
      controller.restartGame();
      return Text(
        "Timer got negative value",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Get.textTheme.bodyLarge?.copyWith(
          color: Colors.red,
          fontSize: 18,
        ),
      );
    }

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
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: " s",
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
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
                  "Chasing time in sec!",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyLarge?.copyWith(fontSize: 18),
                ).padAll(value: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
