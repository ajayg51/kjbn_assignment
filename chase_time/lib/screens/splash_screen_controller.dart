import 'package:chase_time/screens/home_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.off(() => HomeScreen());
      },
    );
  }
}
