import 'package:get/get.dart';

import '../helper/helpers.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _getUserLogInStatus();
    super.onInit();
  }

  RxBool isSignedIn = false.obs;

  _getUserLogInStatus() async {
    await Helpers.getUserStatus().then((value) {
      if (value != null && value == true) {
        isSignedIn.value = true;
      }
    });

  }
}
