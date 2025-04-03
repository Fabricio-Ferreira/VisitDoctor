import 'dart:async';
import 'package:get/get.dart';
import 'package:visit_doctor/app/enum/page_state_enum.dart';
import 'package:visit_doctor/app/utils/dialog_helper_mixin.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/delete_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/get_all_clients_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/delete_visit_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/get_visits_use_case.dart';

import '../../adapter/client_adapter.dart';
import '../../view_model/client_list_view_model.dart';

class ClientController extends GetxController with DialogHelperMixin {
  final DeleteClientUseCase _deleteClientUseCase;
  final GetAllClientsUseCase _getAllClientsUseCase;
  final GetVisitsUseCase _getVisitsUseCase;
  final DeleteVisitUseCase _deleteVisitUseCase;

  ClientController({
    required DeleteClientUseCase deleteClientUseCase,
    required DeleteVisitUseCase deleteVisitUseCase,
    required GetAllClientsUseCase getAllClientsUseCase,
    required GetVisitsUseCase getVisitsUseCase,
  })  : _deleteClientUseCase = deleteClientUseCase,
        _getVisitsUseCase = getVisitsUseCase,
        _deleteVisitUseCase = deleteVisitUseCase,
        _getAllClientsUseCase = getAllClientsUseCase;

  final pageState = PageStateEnum.idle.obs;
  final clients = <ClientEntity>[];
  final viewModel = ClientListViewModel(clients: []).obs;

  Future<void> getAllClients() async {
    pageState.value = PageStateEnum.loading;
    final result = await _getAllClientsUseCase(NoParams());
    result.fold(
      _handleError,
      _handleSuccess,
    );
  }

  Future<void> deleteClient(String id) async {
    pageState.value = PageStateEnum.loading;
    final client = clients.firstWhere((element) => element.id == id);
    if (client.hasVisit) await _removeVisit(client.id);

    final result = await _deleteClientUseCase(id);
    result.fold(
      _handleDeleteError,
      _handleDeleteSuccess,
    );
  }

  void _handleError(Exception l) {
    pageState.value = PageStateEnum.error;
    customSnackBar('Error loading clients');
  }

  void _handleSuccess(List<ClientEntity> r) {
    clients.assignAll(r);
    final model = ClientAdapter.toListViewModel(clients);
    viewModel.value.clients.assignAll(model.clients);

    pageState.value = PageStateEnum.success;
  }

  Future<void> _handleDeleteSuccess(bool result) async {
    if (result) {
      pageState.value = PageStateEnum.success;

      await getAllClients();
    }
  }

  void _handleDeleteError(Exception l) {
    pageState.value = PageStateEnum.error;
    customSnackBar('Error deleting client');
  }

  Future<void> _removeVisit(String clientId) async {
    final result = await _getVisitsUseCase(NoParams());
    if (result.isLeft()) {
      return;
    } else {
      final visits = result.getOrElse(() => []);
      final visit = visits.firstWhere((element) => element.clientId == int.parse(clientId));
      await _deleteVisitUseCase(visit.id);
    }
  }
}
