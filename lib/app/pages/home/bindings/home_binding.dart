import 'package:get/get.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/update_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/home/add_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/home/get_address_by_cep_use_case.dart';

import '../pages/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        getAddressByCepUseCase: Get.find<GetAddressByCepUseCase>(),
        addClientUseCase: Get.find<AddClientUseCase>(),
        updateClientUseCase: Get.find<UpdateClientUseCase>(),
      ),
    );
  }
}
