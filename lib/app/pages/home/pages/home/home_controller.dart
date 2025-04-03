import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/enum/app_tab.dart';
import 'package:visit_doctor/app/enum/page_state_enum.dart';
import 'package:visit_doctor/app/pages/clients/pages/client_list/client_controller.dart';
import 'package:visit_doctor/app/pages/home/adapter/home_adapter.dart';
import 'package:visit_doctor/app/pages/home/arguments/client_arguments.dart';
import 'package:visit_doctor/app/pages/home/view_model/add_client_model_params.dart';
import 'package:visit_doctor/app/pages/home/view_model/home_view_model.dart';
import 'package:visit_doctor/app/pages/main/main_controller.dart';
import 'package:visit_doctor/app/utils/try_cast.dart';
import 'package:visit_doctor/app/utils/widget_utils.dart';
import 'package:visit_doctor/core/domain/entity/address_entity.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/update_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/home/add_client_use_case.dart';
import 'package:visit_doctor/core/domain/use_cases/home/get_address_by_cep_use_case.dart';

import '../../../../utils/dialog_helper_mixin.dart';
import '../../l10n/home_page_l10n_impl.dart';
import '../../view_model/update_client_model_params.dart';

class HomeController extends GetxController with DialogHelperMixin {
  final GetAddressByCepUseCase _getAddressByCepUseCase;
  final AddClientUseCase _addClientUseCase;
  final UpdateClientUseCase _updateClientUseCase;

  HomeController({
    required GetAddressByCepUseCase getAddressByCepUseCase,
    required AddClientUseCase addClientUseCase,
    required UpdateClientUseCase updateClientUseCase,
  })  : _getAddressByCepUseCase = getAddressByCepUseCase,
        _addClientUseCase = addClientUseCase,
        _updateClientUseCase = updateClientUseCase;

  final cepTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final ageTextController = TextEditingController();
  final numberHomeTextController = TextEditingController();
  final referencePointTextController = TextEditingController();

  final stateButton = WidgetState.disabled.obs;
  final pageState = PageStateEnum.idle.obs;
  final isNotEditClient = false.obs;

  final viewModel = HomeViewModel(
    street: '',
    neighborhood: '',
    city: '',
    state: '',
  ).obs;

  late ClientArguments? args;

  Rx<bool> get isButtonDisabled => (nameTextController.text.isNotEmpty &&
          ageTextController.text.isNotEmpty &&
          numberHomeTextController.text.isNotEmpty &&
          !isNotEditClient.value)
      .obs;

  final HomePageL10nImpl homePageL10n = const HomePageL10nImpl();

  Future<void> getAddressByCep() async {
    WidgetUtils.hideKeyboard(Get.context);
    pageState.value = PageStateEnum.loading;
    final cep = cepTextController.text.replaceAll('-', '');
    final result = await _getAddressByCepUseCase(cep);
    result.fold(
      _handleError,
      _handleSuccess,
    );
  }

  void onChanged(String value) {
    pageState.value = PageStateEnum.idle;
    stateButton.value = value.length == 9 ? WidgetState.selected : WidgetState.disabled;
  }

  void _handleError(Exception error) {
    pageState.value = PageStateEnum.error;
    stateButton.value = WidgetState.selected;
    debugPrint('Error: $error');
    update();
    customSnackBar(homePageL10n.errorCepMessage);
  }

  void _handleSuccess(AddressEntity address) {
    final viewModel = HomeAdapter.toViewModel(address);
    this.viewModel.value = viewModel;
    pageState.value = PageStateEnum.success;
    stateButton.value = WidgetState.disabled;
    debugPrint('Address: $address');
    update();
  }

  void onChangedName(String value) {
    nameTextController.text = value;
    if (nameTextController.text.isEmpty) {
      isButtonDisabled.value = false;
    } else {
      isNotEditClient.value = false;
      isButtonDisabled;

      update();
    }
  }

  void onChangedPointReference(String value) {
    referencePointTextController.text = value;

    isNotEditClient.value = false;
    isButtonDisabled;
    update();
  }

  void onChangedNumberHome(String value) {
    numberHomeTextController.text = value;
    if (numberHomeTextController.text.isEmpty) {
      isButtonDisabled.value = false;
    } else {
      isNotEditClient.value = false;
      isButtonDisabled;
      update();
    }
  }

  void onChangedAge(String value) {
    ageTextController.text = value;
    if (ageTextController.text.isEmpty) {
      isButtonDisabled.value = false;
    } else {
      isNotEditClient.value = false;
      isButtonDisabled;
      update();
    }
  }

  Future<void> _saveClient() async {
    WidgetUtils.hideKeyboard(Get.context);
    final params = AddClientModelParams(
      name: nameTextController.text,
      age: int.parse(ageTextController.text),
      hasVisit: 'false',
      address: AddressEntity(
        street: viewModel.value.street,
        neighborhood: viewModel.value.neighborhood,
        city: viewModel.value.city,
        state: viewModel.value.state,
        zipCode: cepTextController.text,
        complement: '',
        numberHome: numberHomeTextController.text,
        referencePoint: referencePointTextController.text,
      ),
    );

    final result = await _addClientUseCase(params);
    result.fold(
      _handleErrorSaveClient,
      _handleSuccessSaveClient,
    );
  }

  void _handleErrorSaveClient(Exception l) => customSnackBar(homePageL10n.errorSaveClientMessage);

  void _handleSuccessSaveClient(ClientEntity r) {
    Get.back();
    final mainController = Get.find<MainController>();
    mainController.changePage(AppTab.clients);
    ageTextController.clear();
    nameTextController.clear();
    numberHomeTextController.clear();
    referencePointTextController.clear();
    customSnackBar(homePageL10n.saveClientSuccessMessage);
  }

  Future<void> onPressed() async {
    if (args != null) {
      await _updateClient();
    } else {
      await _saveClient();
    }
  }

  void init() {
    final arguments = tryCast<ClientArguments>(Get.arguments);
    if (arguments != null) {
      nameTextController.text = arguments.name;
      ageTextController.text = arguments.age.toString();
      numberHomeTextController.text = arguments.numberHome;
      referencePointTextController.text = arguments.referencePoint ?? '';
      viewModel.value = HomeViewModel(
        street: arguments.street,
        neighborhood: arguments.neighborhood,
        city: arguments.city,
        state: arguments.state,
      );
      args = arguments;
      isNotEditClient.value = true;
    } else {
      args = null;
      ageTextController.clear();
      nameTextController.clear();
      numberHomeTextController.clear();
      referencePointTextController.clear();
      isNotEditClient.value = false;
    }
  }

  Future<void> _updateClient() async {
    WidgetUtils.hideKeyboard(Get.context);
    final params = UpdateClientModelParams(
      id: args!.id,
      name: nameTextController.text,
      age: int.parse(ageTextController.text),
      numberHome: numberHomeTextController.text,
      referencePoint: referencePointTextController.text,
      hasVisit: args!.hasVisit ?? 'false',
    );

    final result = await _updateClientUseCase(params);
    result.fold(
      _handleErrorUpdateClient,
      _handleSuccessUpdateClient,
    );
  }

  void _handleErrorUpdateClient(Exception l) =>
      customSnackBar(homePageL10n.errorUpdateClientMessage);

  Future<void> _handleSuccessUpdateClient(bool r) async {
    Get.back();
    final mainController = Get.find<MainController>();
    mainController.changePage(AppTab.clients);
    final clientController = Get.find<ClientController>();
    await clientController.getAllClients();
    ageTextController.clear();
    nameTextController.clear();
    numberHomeTextController.clear();
    referencePointTextController.clear();
    customSnackBar(homePageL10n.updateClientSuccessMessage);
  }
}
