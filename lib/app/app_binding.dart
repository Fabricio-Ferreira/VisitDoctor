import 'package:get/get.dart';
import 'package:visit_doctor/core/modules/data_source_module.dart';
import 'package:visit_doctor/core/modules/repositories_module.dart';
import 'package:visit_doctor/core/modules/use_case_module.dart';

import 'app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    DataSourceModule.init();
    RepositoriesModule.init();
    UseCaseModule.init();
    Get.lazyPut<AppController>(AppController.new);
  }
}
