import 'package:visit_doctor/app/pages/visits/view_model/visit_view_model.dart';

import '../../../../core/domain/entity/visit_entity.dart';

abstract class VisitAdapter {
  VisitAdapter._();

  static VisitListViewModel toListViewModel(List<VisitEntity> visits) {
    final List<VisitViewModel> list = visits
        .map(
          (e) => VisitViewModel(
            visitId: e.id,
            name: e.clientName,
            dateVisit: e.dateVisit,
            reasonVisit: e.reasonVisit,
            clientId: e.clientId,
            observation: e.observation,
          ),
        )
        .toList();

    return VisitListViewModel(visits: list);
  }
}
