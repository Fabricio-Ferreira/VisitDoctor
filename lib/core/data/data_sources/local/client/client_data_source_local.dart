import 'package:visit_doctor/core/data/adapters/model/client_model.dart';

import '../../../../domain/use_cases/params/update_client_params.dart';

abstract class ClientDataSourceLocal {
  Future<int> deleteClient(String clientId);
  Future<List<ClientModel>> getClient(String text);
  Future<List<ClientModel>> getClients();
  Future<int> updateClient(UpdateClientParams params);
}
