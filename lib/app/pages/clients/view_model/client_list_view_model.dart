class ClientListViewModel {
  final List<ClientListModel> clients;

  ClientListViewModel({
    required this.clients,
  });

  ClientListViewModel copyWith({
    List<ClientListModel>? clients,
  }) =>
      ClientListViewModel(
        clients: clients ?? this.clients,
      );
}

class ClientListModel {
  final int id;
  final int age;
  final String name;
  final String city;
  final String uf;
  final bool hasVisit;

  ClientListModel({
    required this.id,
    required this.age,
    required this.name,
    required this.city,
    required this.uf,
    this.hasVisit = false,
  });
}
