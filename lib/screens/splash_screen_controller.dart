import 'package:get/get.dart';
import 'package:kjbn_assignment/screens/home_screen.dart';

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
