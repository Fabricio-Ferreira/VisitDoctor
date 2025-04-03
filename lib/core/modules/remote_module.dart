import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/core/network/custom_dio.dart';

abstract class RemoteModule {
  RemoteModule._();

  static void init() {
    // Initialize remote module
    Get.put<Dio>(CustomDio().instance, permanent: true);
  }
}
