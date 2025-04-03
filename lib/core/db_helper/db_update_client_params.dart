class DbUpdateClientParams {
  final String id;
  final String name;
  final int age;
  final String numberHome;
  final String referencePoint;
  final String hasVisit;

  DbUpdateClientParams({
    required this.id,
    required this.name,
    required this.age,
    required this.numberHome,
    required this.referencePoint,
    this.hasVisit = 'false',
  });
}
