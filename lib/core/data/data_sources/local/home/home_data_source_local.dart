import 'package:visit_doctor/core/domain/use_cases/params/add_client_params.dart';

import '../../../adapters/model/client_model.dart';

abstract class HomeDataSourceLocal {
  Future<ClientModel> addClient(AddClientParams params);
}
