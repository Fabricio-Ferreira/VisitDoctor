class VisitArguments {
  final String id;
  final String name;
  final int age;
  final String city;
  final String state;
  final String reasonVisit;
  final String dateVisit;
  final String? observationVisit;

  VisitArguments({
    required this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.state,
    required this.reasonVisit,
    required this.dateVisit,
    this.observationVisit,
  });
}
