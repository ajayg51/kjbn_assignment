import 'dart:async';
import 'dart:math';

import 'package:chase_time/models/info_model.dart';
import 'package:chase_time/services/sqlite_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class HomeScreenController extends GetxController {
  final currentSecond = 0.obs;
  final randomValue = 0.obs;

  final successCount = 0.obs;
  final failureCount = 0.obs;
  final timeupCount = 0.obs;

  final attemptCount = 0.obs;
  final timerSecond = 5.obs;
  final isShowGameInfo = true.obs;

  final dbErr = "".obs;

  final isSuccess = false.obs;
  final isTimeup = false.obs;

  final data = <InfoModel>[].obs;

  Timer? timer;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 700));

  @override
  void onReady() {
    super.onReady();
    currentSecond.value = DateTime.now().second;
    countSecond(isStopTimer: false);

    try {
      SqliteService.initializeDB().whenComplete(() async {
        final list = await SqliteService.getItems();
        data.assignAll(list);
        resetGameInfo();
      });
    } catch (e) {
      dbErr.value += e.toString();
    }
  }

  void resetGameInfo() {
    currentSecond.value = 0;
    randomValue.value = 0;

    final latestDataIdx = data.length - 1;
    successCount.value = data[latestDataIdx].successCount;
    failureCount.value = data[latestDataIdx].failureCount;
    timeupCount.value = data[latestDataIdx].timeupCount;
    attemptCount.value = data[latestDataIdx].attemptCount;
    timerSecond.value = 5;

    isSuccess.value = false;
    isTimeup.value = false;
  }

  void onBtnTap() {
    debouncer.call(() async {
      if (timerSecond.value < 0) {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }
        return;
      }

      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }

      if (isShowGameInfo.value) {
        isShowGameInfo.value = false;
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
        failureCount.value += 1;
        countSecond(isStopTimer: false);
      }

      try {
        await SqliteService.createRecord(
          InfoModel(
            failureCount: failureCount.value,
            successCount: successCount.value,
            timeupCount: timeupCount.value,
            attemptCount: attemptCount.value,
          ),
        );
      } catch (e) {
        dbErr.value += e.toString();
      }
      // try {
      //   SqliteService.initializeDB().whenComplete(() async {
      //     final list = await SqliteService.getItems();
      //     data.assignAll(list);
      //   });
      // } catch (e) {
      //   dbErr.value += e.toString();
      // }
    });
  }

  void countSecond({required bool isStopTimer}) {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    Timer.periodic(
      const Duration(milliseconds: 999),
      (timer) async {
        this.timer = timer;
        if (isStopTimer) {
          timer.cancel();
          return;
        }

        timerSecond.value -= 1;
        if (timerSecond.value == 0) {
          isSuccess.value = false;
          timeupCount.value += 1;
          isTimeup.value = true;
          if (isShowGameInfo.value) {
            isShowGameInfo.value = false;
          }
          try {
            await SqliteService.createRecord(
              InfoModel(
                failureCount: failureCount.value,
                successCount: successCount.value,
                timeupCount: timeupCount.value,
                attemptCount: attemptCount.value,
              ),
            );
          } catch (e) {
            dbErr.value += e.toString();
          }
          timer.cancel();
        }
      },
    );
  }

  void showSnackbar({required String msg}) async {
    if (Get.isSnackbarOpen) {
      return;
    }
    Get.showSnackbar(
      GetSnackBar(
        title: "Db info : ",
        message: msg,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    Get.closeAllSnackbars();
  }
}
