import 'package:get/get.dart';
import 'package:visit_doctor/core/data/data_sources/remote/home/home_data_source_remote.dart';
import 'package:visit_doctor/core/data/repositories/home_repository_impl.dart';
import 'package:visit_doctor/core/domain/repositories/home_repository.dart';

import '../data/data_sources/local/client/client_data_source_local.dart';
import '../data/data_sources/local/home/home_data_source_local.dart';
import '../data/data_sources/local/visit/visit_data_source_local.dart';
import '../data/repositories/client_repository_impl.dart';
import '../data/repositories/visit_repository_impl.dart';
import '../domain/repositories/client_repository.dart';
import '../domain/repositories/visit_repository.dart';

abstract class RepositoriesModule {
  RepositoriesModule._();

  static void init() {
    // Initialize repositories module
    _injectHomeRepository();
    _injectClientRepository();
    _injectVisitRepository();
  }

  static void _injectHomeRepository() {
    // Inject HomeRepository
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(Get.find<HomeDataSourceRemote>(), Get.find<HomeDataSourceLocal>()),
      fenix: true,
    );
  }

  static void _injectClientRepository() {
    // Inject ClientRepository
    Get.lazyPut<ClientRepository>(
      () => ClientRepositoryImpl(localDataSource: Get.find<ClientDataSourceLocal>()),
      fenix: true,
    );
  }

  static void _injectVisitRepository() {
    // Inject VisitRepository
    Get.lazyPut<VisitRepository>(
      () => VisitRepositoryImpl(localDataSource: Get.find<VisitDataSourceLocal>()),
      fenix: true,
    );
  }
}
