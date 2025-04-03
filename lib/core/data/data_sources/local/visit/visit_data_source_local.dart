import 'package:visit_doctor/core/data/adapters/model/visit_model.dart';
import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';

abstract class VisitDataSourceLocal {
  Future<int> deleteVisit(int visitId);
  Future<List<VisitModel>> getVisits();
  Future<int> updateVisit(VisitDataParams params);
  Future<VisitModel> createVisit(VisitDataParams params);
}
