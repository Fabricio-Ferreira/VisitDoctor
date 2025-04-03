import 'package:get/get.dart';
import 'package:visit_doctor/core/db_helper/data_base_helper.dart';
import 'package:visit_doctor/core/domain/use_cases/params/update_client_params.dart';

import '../../../../db_helper/db_update_client_params.dart';
import '../../../adapters/model/client_model.dart';
import 'client_data_source_local.dart';

class ClientDataSourceLocalImpl implements ClientDataSourceLocal {
  @override
  Future<int> deleteClient(String clientId) async {
    final id = int.parse(clientId);
    return DatabaseHelper.instance.deleteClient(id);
  }

  @override
  Future<List<ClientModel>> getClient(String text) async {
    final listClientFiltered = <ClientModel>[];
    final result = await DatabaseHelper.instance.getAllClients();
    final listClients = result.map(ClientModel.fromMap).toList();
    listClientFiltered.assignAll(listClients
        .where((client) => client.name.toLowerCase().contains(text.toLowerCase()))
        .toList());
    return listClientFiltered;
  }

  @override
  Future<List<ClientModel>> getClients() async {
    final result = await DatabaseHelper.instance.getAllClients();
    return result.map(ClientModel.fromMap).toList();
  }

  @override
  Future<int> updateClient(UpdateClientParams params) async {
    final dbParams = DbUpdateClientParams(
      id: params.id,
      name: params.name,
      age: params.age,
      numberHome: params.numberHome,
      referencePoint: params.referencePoint,
      hasVisit: params.hasVisit,
    );
    return DatabaseHelper.instance.updateClient(dbParams);
  }
}
