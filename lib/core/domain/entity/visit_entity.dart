import 'package:equatable/equatable.dart';

class VisitEntity extends Equatable {
  final int id;
  final int clientId;
  final String dateVisit;
  final String reasonVisit;
  final String observation;
  final String clientName;

  const VisitEntity({
    required this.id,
    required this.clientId,
    required this.dateVisit,
    required this.reasonVisit,
    required this.observation,
    required this.clientName,
  });

  VisitEntity copyWith({
    int? id,
    int? clientId,
    String? dateVisit,
    String? reasonVisit,
    String? observation,
    String? clientName,
  }) =>
      VisitEntity(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        dateVisit: dateVisit ?? this.dateVisit,
        reasonVisit: reasonVisit ?? this.reasonVisit,
        observation: observation ?? this.observation,
        clientName: clientName ?? this.clientName,
      );

  @override
  List<Object?> get props => [
        id,
        clientId,
        dateVisit,
        reasonVisit,
        observation,
        clientName,
      ];
}
