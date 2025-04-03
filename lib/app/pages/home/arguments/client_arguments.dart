class ClientArguments {
  final String id;
  final String name;
  final int age;
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String complement;
  final String numberHome;
  final String? referencePoint;
  final String? hasVisit;

  ClientArguments({
    required this.id,
    required this.name,
    required this.age,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.complement,
    required this.numberHome,
    required this.referencePoint,
    this.hasVisit = 'false',
  });
}
