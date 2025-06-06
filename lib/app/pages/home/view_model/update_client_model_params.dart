class UpdateClientModelParams {
  final String id;
  final String name;
  final int age;
  final String numberHome;
  final String referencePoint;
  final String hasVisit;

  UpdateClientModelParams({
    required this.id,
    required this.name,
    required this.age,
    required this.numberHome,
    required this.referencePoint,
    this.hasVisit = 'false',
  });
}
