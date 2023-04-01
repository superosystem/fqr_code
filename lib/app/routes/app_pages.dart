import 'package:get/get.dart';
import 'package:moslem/app/modules/home/bindings/home_binding.dart';
import 'package:moslem/app/modules/home/views/home_view.dart';
import 'package:moslem/app/modules/introduction/bindings/introduction_binding.dart';
import 'package:moslem/app/modules/introduction/views/introduction_view.dart';
import 'package:moslem/app/modules/surah/bindings/surah_binding.dart';
import 'package:moslem/app/modules/surah/detail_surah/bindings/detail_surah_binding.dart';
import 'package:moslem/app/modules/surah/detail_surah/views/detail_surah_view.dart';
import 'package:moslem/app/modules/surah/views/surah_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRODUCTION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.SURAH,
      page: () => SurahView(),
      binding: SurahBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH,
      page: () => DetailSurahView(),
      binding: DetailSurahBinding(),
    ),
  ];
}
