import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'package:visit_doctor/core/db_helper/data_base_helper.dart';

abstract class LocalModule {
  LocalModule._();

  static Future<void> init() async {
    // Initialize local module
    final db = await DatabaseHelper.instance.database;

    Get.put<Database>(db, permanent: true);
  }
}
