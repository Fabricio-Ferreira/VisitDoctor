import 'package:get/get.dart';

import 'package:visit_doctor/app/enum/page_state_enum.dart';
import 'package:visit_doctor/app/pages/visits/view_model/visit_view_model.dart';
import 'package:visit_doctor/app/utils/dialog_helper_mixin.dart';
import 'package:visit_doctor/core/domain/entity/visit_entity.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/delete_visit_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/get_visits_use_case.dart';

import '../../../../../core/domain/use_cases/clients/update_client_use_case.dart';
import '../../../clients/pages/client_list/client_controller.dart';
import '../../../home/view_model/update_client_model_params.dart';
import '../../adapter/visit_adapter.dart';

class VisitsController extends GetxController with DialogHelperMixin {
  final GetVisitsUseCase _getVisitsUseCase;
  final DeleteVisitUseCase _deleteVisitUseCase;
  final UpdateClientUseCase _updateClientUseCase;

  VisitsController({
    required GetVisitsUseCase getVisitsUseCase,
    required DeleteVisitUseCase deleteVisitUseCase,
    required UpdateClientUseCase updateClientUseCase,
  })  : _getVisitsUseCase = getVisitsUseCase,
        _updateClientUseCase = updateClientUseCase,
        _deleteVisitUseCase = deleteVisitUseCase;

  final pageState = PageStateEnum.idle.obs;
  final viewModel = VisitListViewModel(visits: []).obs;
  late String visitId = '';

  Future<void> getVisits() async {
    pageState.value = PageStateEnum.loading;
    final result = await _getVisitsUseCase(NoParams());
    result.fold(
      _handleError,
      _handleSuccess,
    );
  }

  Future<void> deleteVisit(String id) async {
    pageState.value = PageStateEnum.loading;
    visitId = id;
    final result = await _deleteVisitUseCase(int.parse(id));
    result.fold(
      _handleError,
      _handleDeleteVisitSuccess,
    );
  }

  void _handleError(Exception l) => customSnackBar('Erro ao carregar as visitas');

  void _handleSuccess(List<VisitEntity> list) {
    viewModel.value = VisitAdapter.toListViewModel(list);
    pageState.value = PageStateEnum.success;
  }

  Future<void> _handleDeleteVisitSuccess(bool result) async {
    if (result) {
      Get.back();
      await _updateClientHasVisit();
      pageState.value = PageStateEnum.success;
      customSnackBar('Visita apagada');
      await getVisits();
    }
  }

  Future<void> _updateClientHasVisit() async {
    final visit = viewModel.value.visits.firstWhere(
      (element) => element.visitId == int.parse(visitId),
    );
    final clientController = Get.find<ClientController>();
    await clientController.getAllClients();
    final client = clientController.clients.firstWhere(
      (element) => int.parse(element.id) == visit.clientId,
    );

    final params = UpdateClientModelParams(
      id: client.id.toString(),
      name: client.name,
      age: client.age,
      numberHome: client.address.numberHome ?? '',
      referencePoint: client.address.referencePoint ?? '',
      hasVisit: 'false',
    );
    await _updateClientUseCase(params);
  }
}
