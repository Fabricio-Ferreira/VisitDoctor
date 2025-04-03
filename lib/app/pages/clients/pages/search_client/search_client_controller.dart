// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:visit_doctor/app/enum/page_state_enum.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';
import 'package:visit_doctor/core/domain/use_cases/clients/get_client_use_case.dart';

import '../../adapter/client_adapter.dart';
import '../../view_model/client_list_view_model.dart';

class SearchClientController extends GetxController {
  final GetClientUseCase _getClientUseCase;
  SearchClientController({required GetClientUseCase getClientUseCase})
      : _getClientUseCase = getClientUseCase;

  final pageState = PageStateEnum.idle.obs;
  final viewModel = ClientListViewModel(clients: []).obs;
  final searchController = TextEditingController();

  final _debounce = Timer(const Duration(milliseconds: 1000), () {}).obs;

  Rx<Timer> get debounce => _debounce;

  void clearSearch() {
    searchController.clear();
    viewModel.value.clients.clear();
    pageState.value = PageStateEnum.idle;
    update();
  }

  Future<void> onSearch(String value) async {
    pageState.value = PageStateEnum.loading;
    final result = await _getClientUseCase(value);
    result.fold(
      _handleError,
      _handleSuccess,
    );
  }

  void _handleError(Exception l) {
    viewModel.value = viewModel.value.copyWith(clients: []);
    pageState.value = PageStateEnum.error;
    update();
  }

  void _handleSuccess(List<ClientEntity> clients) {
    if (clients.isEmpty) {
      viewModel.value = viewModel.value.copyWith(clients: []);
      pageState.value = PageStateEnum.error;
      return;
    }

    final model = ClientAdapter.toListViewModel(clients);
    viewModel.value.clients.assignAll(model.clients);

    pageState.value = PageStateEnum.success;
    update();
  }
}
