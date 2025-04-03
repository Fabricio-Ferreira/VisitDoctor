import 'package:get/get.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/delete_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/get_all_clients_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/get_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/get_visits_use_case.dart';

import '../../../../core/domain/use_cases/visits/delete_visit_use_case.dart';
import '../pages/client_list/client_controller.dart';
import '../pages/search_client/search_client_controller.dart';

class ClientsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(
      () => ClientController(
        deleteClientUseCase: Get.find<DeleteClientUseCase>(),
        getAllClientsUseCase: Get.find<GetAllClientsUseCase>(),
        getVisitsUseCase: Get.find<GetVisitsUseCase>(),
        deleteVisitUseCase: Get.find<DeleteVisitUseCase>(),
      ),
    );

    Get.lazyPut<SearchClientController>(
      () => SearchClientController(
        getClientUseCase: Get.find<GetClientUseCase>(),
      ),
      fenix: true,
    );
  }
}
