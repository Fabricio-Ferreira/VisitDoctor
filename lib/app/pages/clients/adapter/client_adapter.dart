import 'package:visit_doctor/app/pages/clients/view_model/client_list_view_model.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';

abstract class ClientAdapter {
  ClientAdapter._();

  static ClientListViewModel toListViewModel(List<ClientEntity> clients) {
    final List<ClientListModel> clientsList = clients
        .map(
          (client) => ClientListModel(
            id: int.parse(client.id),
            age: client.age,
            name: client.name,
            city: client.address.city,
            uf: client.address.state,
            hasVisit: client.hasVisit,
          ),
        )
        .toList();

    final Iterable<ClientListModel> listReversed = clientsList.reversed;
    return ClientListViewModel(clients: listReversed.toList());
  }
}
