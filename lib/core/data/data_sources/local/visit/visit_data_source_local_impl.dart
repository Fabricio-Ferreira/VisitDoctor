import 'package:visit_doctor/core/data/adapters/model/visit_model.dart';
import 'package:visit_doctor/core/data/data_sources/local/visit/visit_data_source_local.dart';
import 'package:visit_doctor/core/db_helper/data_base_helper.dart';

import '../../../../db_helper/db_update_visit_params.dart';
import '../../../../domain/use_cases/params/visit_data_params.dart';

class VisitDataSourceLocalImpl implements VisitDataSourceLocal {
  @override
  Future<int> deleteVisit(int visitId) async => DatabaseHelper.instance.deleteVisit(visitId);

  @override
  Future<List<VisitModel>> getVisits() async {
    final result = await DatabaseHelper.instance.getAllVisits();
    return result.map(VisitModel.fromMap).toList();
  }

  @override
  Future<int> updateVisit(VisitDataParams params) async {
    final dbParams = DbUpdateVisitParams.toDbParams(params);
    return DatabaseHelper.instance.updateVisit(dbParams);
  }

  @override
  Future<VisitModel> createVisit(VisitDataParams params) async {
    final dbParams = DbUpdateVisitParams.toDbParams(params);

    final result = await DatabaseHelper.instance.insertVisit(dbParams);
    if (result < 1) {
      throw Exception('Error inserting visit');
    }

    final model = VisitModel(
      id: result,
      clientId: dbParams.clientId,
      dateVisit: dbParams.dateVisit,
      reasonVisit: dbParams.reasonVisit,
      observation: dbParams.observation,
      clientName: dbParams.clientName,
    );

    return model;
  }
}
