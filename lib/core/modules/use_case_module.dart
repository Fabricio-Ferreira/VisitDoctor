import 'package:get/get.dart';
import 'package:visit_doctor/core/domain/repositories/home_repository.dart';
import 'package:visit_doctor/core/domain/use_cases/home/get_address_by_cep_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/create_visit_use_case.dart';

import '../domain/repositories/client_repository.dart';
import '../domain/repositories/visit_repository.dart';
import '../domain/use_cases/clients/delete_client_use_case.dart';
import '../domain/use_cases/clients/get_all_clients_use_case.dart';
import '../domain/use_cases/clients/get_client_use_case.dart';
import '../domain/use_cases/clients/update_client_use_case.dart';
import '../domain/use_cases/home/add_client_use_case.dart';
import '../domain/use_cases/visits/delete_visit_use_case.dart';
import '../domain/use_cases/visits/get_visits_use_case.dart';
import '../domain/use_cases/visits/update_visit_use_case.dart';

abstract class UseCaseModule {
  UseCaseModule._();

  static void init() {
    // Initialize use case module
    _injectHomeUseCase();
    _injectClientUseCase();
    _injectVisitUseCase();
  }

  static void _injectHomeUseCase() {
    // Inject HomeUseCase
    Get.lazyPut<GetAddressByCepUseCase>(
      () => GetAddressByCepUseCase(Get.find<HomeRepository>()),
      fenix: true,
    );

    // Inject AddClientUseCase
    Get.lazyPut<AddClientUseCase>(
      () => AddClientUseCase(homeRepository: Get.find<HomeRepository>()),
      fenix: true,
    );
  }

  static void _injectClientUseCase() {
    // Inject GetAllClientUseCase
    Get.lazyPut<GetAllClientsUseCase>(
      () => GetAllClientsUseCase(clientRepository: Get.find<ClientRepository>()),
      fenix: true,
    );

    // Inject DeleteClientUseCase
    Get.lazyPut<DeleteClientUseCase>(
      () => DeleteClientUseCase(clientRepository: Get.find<ClientRepository>()),
      fenix: true,
    );

    // Inject GetClientUseCase
    Get.lazyPut<GetClientUseCase>(
      () => GetClientUseCase(clientRepository: Get.find<ClientRepository>()),
      fenix: true,
    );

    // Inject UpdateClientUseCase
    Get.lazyPut<UpdateClientUseCase>(
      () => UpdateClientUseCase(clientRepository: Get.find<ClientRepository>()),
      fenix: true,
    );
  }

  static void _injectVisitUseCase() {
    // Inject VisitUseCase
    Get.lazyPut<CreateVisitUseCase>(
      () => CreateVisitUseCase(repository: Get.find<VisitRepository>()),
      fenix: true,
    );

    // Inject GetVisitsUseCase
    Get.lazyPut<GetVisitsUseCase>(
      () => GetVisitsUseCase(repository: Get.find<VisitRepository>()),
      fenix: true,
    );

    // Inject DeleteVisitUseCase
    Get.lazyPut<DeleteVisitUseCase>(
      () => DeleteVisitUseCase(repository: Get.find<VisitRepository>()),
      fenix: true,
    );

    // Inject UpdateVisitUseCase
    Get.lazyPut<UpdateVisitUseCase>(
      () => UpdateVisitUseCase(repository: Get.find<VisitRepository>()),
      fenix: true,
    );
  }
}
