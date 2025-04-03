import 'package:visit_doctor/core/domain/entity/visit_entity.dart';

class VisitModel extends VisitEntity {
  const VisitModel({
    required super.id,
    required super.clientId,
    required super.dateVisit,
    required super.reasonVisit,
    required super.observation,
    required super.clientName,
  });

  factory VisitModel.fromMap(Map<String, dynamic> map) => VisitModel(
        id: map['id_visit'],
        clientId: map['id'],
        dateVisit: map['date_visit'],
        reasonVisit: map['reason_visit'],
        observation: map['observation_visit'],
        clientName: map['name_client'],
      );
}
