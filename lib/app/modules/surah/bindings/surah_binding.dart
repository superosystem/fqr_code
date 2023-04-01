import 'package:get/get.dart';

import '../controllers/surah_controller.dart';

class SurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurahController>(
      () => SurahController(),
    );
  }
}
