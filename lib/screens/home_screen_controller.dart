import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class HomeScreenController extends GetxController {
  final currentSecond = 0.obs;
  final randomValue = 0.obs;

  final successCount = 0.obs;
  final failureCount = 0.obs;

  final attemptCount = 0.obs;
  final timerSecond = 5.obs;

  final isSuccess = false.obs;
  final isTimeup = false.obs;

  Timer? timer;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 700));

  @override
  void onReady() {
    super.onReady();
    currentSecond.value = DateTime.now().second;
    countSecond(isStopTimer: false);
  }

  void restartGame() {
    currentSecond.value = 0;
    randomValue.value = 0;

    successCount.value = 0;
    failureCount.value = 0;

    attemptCount.value = 0;
    timerSecond.value = 5;

    isSuccess.value = false;
    isTimeup.value = false;
  }

  void onBtnTap() {
    debouncer.call(() {
      if (timerSecond.value < 0) {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }
        return;
      }

      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }

      currentSecond.value = DateTime.now().second;
      randomValue.value = Random().nextInt(60);
      timerSecond.value = 5;

      attemptCount.value += 1;

      if (currentSecond.value == randomValue.value) {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }

        successCount.value += 1;
        isSuccess.value = true;
      } else {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }

        countSecond(isStopTimer: false);
      }
    });
  }

  void countSecond({required bool isStopTimer}) {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    Timer.periodic(
      const Duration(milliseconds: 999),
      (timer) {
        this.timer = timer;
        if (isStopTimer) {
          timer.cancel();
          return;
        }

        timerSecond.value -= 1;
        if (timerSecond.value == 0) {
          isSuccess.value = false;
          failureCount.value += 1;
          isTimeup.value = true;
          timer.cancel();
        }
      },
    );
  }

  void onRestart() {
    isSuccess.value = false;
  }
}
