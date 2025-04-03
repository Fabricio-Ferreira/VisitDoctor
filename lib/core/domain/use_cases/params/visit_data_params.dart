class VisitDataParams {
  final int? visitId;
  final int clientId;
  final String dateVisit;
  final String reasonVisit;
  final String observation;
  final String clientName;
  final String? hasVisit;

  VisitDataParams({
    required this.clientId,
    required this.dateVisit,
    required this.reasonVisit,
    required this.observation,
    required this.clientName,
    this.visitId,
    this.hasVisit = 'false',
  });
}
