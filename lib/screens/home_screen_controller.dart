import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class HomeScreenController extends GetxController {
  final currentSecond = 0.obs;
  final randomValue = 0.obs;
  final attemptCount = 0.obs;
  final timerSecond = 5.obs;

  final isRestartGame = false.obs;
  final isSuccess = false.obs;
  final isTimeup = false.obs;

  Timer? timer;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 1010));

  @override
  void onReady() {
    super.onReady();
    currentSecond.value = DateTime.now().second;
    countSecond(isStopTimer: false);
  }

  void onBtnTap() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    debouncer.call(() {
      currentSecond.value = DateTime.now().second;
      randomValue.value = Random().nextInt(60);
      // currentSecond.value = 1;
      // randomValue.value = 1;
      timerSecond.value = 5;

      attemptCount.value += 1;

      if (currentSecond.value == randomValue.value) {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }
        isSuccess.value = true;
      } else {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }
        countSecond(isStopTimer: false);
        isRestartGame.value = true;
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
          isTimeup.value = true;
          timer.cancel();
        }
      },
    );
  }
}
