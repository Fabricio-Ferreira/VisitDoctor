import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/visits/pages/create_visit/create_visit_controller.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/create_visit_use_case.dart';

import '../../../../core/domain/use_cases/clients/update_client_use_case.dart';
import '../../../../core/domain/use_cases/visits/delete_visit_use_case.dart';
import '../../../../core/domain/use_cases/visits/get_visits_use_case.dart';
import '../../../../core/domain/use_cases/visits/update_visit_use_case.dart';
import '../pages/visits_list/visits_controller.dart';

class VisitsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitsController>(
      () => VisitsController(
        getVisitsUseCase: Get.find<GetVisitsUseCase>(),
        deleteVisitUseCase: Get.find<DeleteVisitUseCase>(),
        updateClientUseCase: Get.find<UpdateClientUseCase>(),
      ),
    );
    Get.lazyPut<CreateVisitController>(
      () => CreateVisitController(
        createVisitUseCase: Get.find<CreateVisitUseCase>(),
        updateClientUseCase: Get.find<UpdateClientUseCase>(),
        updateVisitUseCase: Get.find<UpdateVisitUseCase>(),
      ),
    );
  }
}
