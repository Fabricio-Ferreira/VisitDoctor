import 'package:get/get.dart';
import 'package:visit_doctor/core/data/data_sources/remote/home/home_data_source_remote.dart';
import 'package:visit_doctor/core/data/data_sources/remote/home/home_data_source_remote_impl.dart';

import '../data/data_sources/local/client/client_data_source_local.dart';
import '../data/data_sources/local/client/client_data_source_local_impl.dart';
import '../data/data_sources/local/home/home_data_source_local.dart';
import '../data/data_sources/local/home/home_data_source_local_impl.dart';
import '../data/data_sources/local/visit/visit_data_source_local.dart';
import '../data/data_sources/local/visit/visit_data_source_local_impl.dart';

abstract class DataSourceModule {
  DataSourceModule._();

  static void init() {
    // Initialize data source module
    _injectHomeDataSourceRemote();
    _injectHomeDataSourceLocal();
    _injectClientDataSourceLocal();
    _injectVisitDataSourceLocal();
  }

  static void _injectHomeDataSourceRemote() {
    // Inject HomeDataSource
    Get.lazyPut<HomeDataSourceRemote>(
      () => HomeDataSourceRemoteImpl(dio: Get.find()),
      fenix: true,
    );
  }

  static void _injectHomeDataSourceLocal() {
    // Inject HomeDataSource
    Get.lazyPut<HomeDataSourceLocal>(
      HomeDataSourceLocalImpl.new,
      fenix: true,
    );
  }

  static void _injectClientDataSourceLocal() {
    // Inject ClientDataSource
    Get.lazyPut<ClientDataSourceLocal>(
      ClientDataSourceLocalImpl.new,
      fenix: true,
    );
  }

  static void _injectVisitDataSourceLocal() {
    // Inject VisitDataSource
    Get.lazyPut<VisitDataSourceLocal>(
      VisitDataSourceLocalImpl.new,
      fenix: true,
    );
  }
}
