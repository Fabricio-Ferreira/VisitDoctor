import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';

class DbUpdateVisitParams {
  final int? visitId;
  final int clientId;
  final String dateVisit;
  final String reasonVisit;
  final String observation;
  final String clientName;

  const DbUpdateVisitParams({
    required this.clientId,
    required this.dateVisit,
    required this.reasonVisit,
    required this.observation,
    required this.clientName,
    this.visitId,
  });

  @override
  factory DbUpdateVisitParams.toDbParams(VisitDataParams params) => DbUpdateVisitParams(
        clientId: params.clientId,
        dateVisit: params.dateVisit,
        reasonVisit: params.reasonVisit,
        observation: params.observation,
        clientName: params.clientName,
        visitId: params.visitId,
      );
}
