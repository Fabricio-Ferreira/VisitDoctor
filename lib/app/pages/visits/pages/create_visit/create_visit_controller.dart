import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/enum/app_tab.dart';
import 'package:visit_doctor/app/pages/clients/pages/client_list/client_controller.dart';

import 'package:visit_doctor/app/pages/clients/view_model/client_list_view_model.dart';
import 'package:visit_doctor/app/pages/main/main_controller.dart';
import 'package:visit_doctor/app/pages/visits/arguments/visit_arguments.dart';
import 'package:visit_doctor/app/utils/try_cast.dart';
import 'package:visit_doctor/core/domain/entity/visit_entity.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/update_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/create_visit_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/visits/update_visit_use_case.dart';

import '../../../../utils/dialog_helper_mixin.dart';
import '../../../home/view_model/update_client_model_params.dart';
import '../visits_list/visits_controller.dart';

class CreateVisitController extends GetxController with DialogHelperMixin {
  final CreateVisitUseCase _createVisitUseCase;
  final UpdateClientUseCase _updateClientUseCase;
  final UpdateVisitUseCase _updateVisitUseCase;

  CreateVisitController({
    required CreateVisitUseCase createVisitUseCase,
    required UpdateClientUseCase updateClientUseCase,
    required UpdateVisitUseCase updateVisitUseCase,
  })  : _createVisitUseCase = createVisitUseCase,
        _updateVisitUseCase = updateVisitUseCase,
        _updateClientUseCase = updateClientUseCase;

  late VisitArguments? args;
  final observationTextController = TextEditingController();
  final reasonVisitTextController = TextEditingController();
  final dateVisitTextController = TextEditingController().obs;
  final isNotEditVisit = false.obs;
  final isDropdownOpen = false.obs;

  final client = ClientListModel(
    id: 0,
    age: 0,
    name: '',
    city: '',
    uf: '',
  ).obs;

  Rx<bool> get isButtonDisabled => (dateVisitTextController.value.text.isNotEmpty &&
          reasonVisitTextController.text.isNotEmpty &&
          !isNotEditVisit.value)
      .obs;

  void init() {
    final arguments = tryCast<VisitArguments>(Get.arguments);
    if (arguments != null) {
      args = arguments;
      client(ClientListModel(
        id: int.parse(args!.id),
        age: args!.age,
        name: args!.name,
        city: args!.city,
        uf: args!.state,
      ));
      if (args!.reasonVisit.isNotEmpty) {
        reasonVisitTextController.text = args!.reasonVisit;
        dateVisitTextController.value.text = args!.dateVisit;
        observationTextController.text = args?.observationVisit ?? '';
        isNotEditVisit.value = true;
      }
    } else {
      args = null;
      reasonVisitTextController.clear();
      dateVisitTextController.value.clear();
      observationTextController.clear();
      isNotEditVisit.value = false;
    }
  }

  void onChangedObservation(String text) {
    observationTextController.text = text;
    update();
  }

  void onChangedDateVisit(String dateVisit) {
    dateVisitTextController.value.text = dateVisit;
    isButtonDisabled;
    isNotEditVisit.value = false;
    update();
  }

  void onChangedReasonVisit(String text) {
    reasonVisitTextController.text = text;
    isNotEditVisit.value = false;
    isDropdownOpen.value = false;
    isButtonDisabled;
    update();
  }

  Future<void> onPressed() async {
    if (args != null && args!.reasonVisit.isNotEmpty) {
      await updateVisit();
    } else {
      await createVisit();
    }
  }

  Future<void> createVisit() async {
    final params = VisitDataParams(
      clientId: client.value.id,
      reasonVisit: reasonVisitTextController.text,
      dateVisit: dateVisitTextController.value.text,
      observation: observationTextController.text,
      clientName: client.value.name,
      hasVisit: 'true',
    );
    final result = await _createVisitUseCase(params);
    result.fold(
      _handleErrorCreateVisit,
      _handleSuccessCreateVisit,
    );
  }

  void _handleErrorCreateVisit(Exception l) => customSnackBar('Falha ao tentar cadastrar a visita');

  Future<void> _handleSuccessCreateVisit(VisitEntity r) async {
    await _updateClient();
  }

  Future<void> _updateClient() async {
    final clientController = Get.find<ClientController>();

    final params = UpdateClientModelParams(
      id: client.value.id.toString(),
      name: client.value.name,
      age: client.value.age,
      numberHome: clientController.clients
              .firstWhere((element) => int.parse(element.id) == client.value.id)
              .address
              .numberHome ??
          '',
      referencePoint: clientController.clients
              .firstWhere((element) => int.parse(element.id) == client.value.id)
              .address
              .referencePoint ??
          '',
      hasVisit: 'true',
    );
    final result = await _updateClientUseCase(params);
    result.fold(
      _handleErrorCreateVisit,
      _handleSuccess,
    );
  }

  Future<void> _handleSuccess(bool result) async {
    if (result) {
      Get.back();
      final mainController = Get.find<MainController>();
      mainController.changePage(AppTab.visits);
      final clientController = Get.find<ClientController>();
      await clientController.getAllClients();
      reasonVisitTextController.clear();
      dateVisitTextController.value.clear();
      observationTextController.clear();
      customSnackBar('Visita cadastrada com sucesso');
    }
  }

  Future<void> updateVisit() async {
    final params = VisitDataParams(
      clientId: client.value.id,
      reasonVisit: reasonVisitTextController.text,
      dateVisit: dateVisitTextController.value.text,
      observation: observationTextController.text,
      clientName: client.value.name,
      visitId: int.parse(args!.id),
    );
    final result = await _updateVisitUseCase(params);
    result.fold(
      _handleErrorUpdateVisit,
      _handleSuccessUpdateVisit,
    );
  }

  void _handleErrorUpdateVisit(Exception l) => customSnackBar('Falha ao tentar atualizar a visita');

  Future<void> _handleSuccessUpdateVisit(bool result) async {
    if (result) {
      final visitController = Get.find<VisitsController>();
      await visitController.getVisits();
      customSnackBar('Alterações salvas com sucesso');
      isNotEditVisit.value = true;
    }
  }
}
