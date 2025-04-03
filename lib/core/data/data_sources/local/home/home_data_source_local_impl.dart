import 'package:visit_doctor/core/db_helper/data_base_helper.dart';

import '../../../../domain/use_cases/params/add_client_params.dart';
import '../../../adapters/model/client_model.dart';
import 'home_data_source_local.dart';

class HomeDataSourceLocalImpl implements HomeDataSourceLocal {
  @override
  Future<ClientModel> addClient(AddClientParams params) async {
    final result = await DatabaseHelper.instance.insertClient(params.toMap());
    final client = ClientModel(
      id: result.toString(),
      name: params.name,
      age: params.age,
      address: params.address,
      hasVisit: false,
    );

    return client;
  }
}
