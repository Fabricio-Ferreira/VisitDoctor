import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/enum/page_state_enum.dart';
import 'package:visit_doctor/app/images/svg/svg_images.dart';
import 'package:visit_doctor/app/pages/clients/pages/search_client/search_client_controller.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';
import 'package:visit_doctor/app/utils/widget_utils.dart';

import '../../../home/arguments/client_arguments.dart';
import '../../../home/pages/add_client/home_add_client_page.dart';
import '../../l10n/client_page_l10n_impl.dart';
import '../../view_model/client_list_view_model.dart';
import '../../widgets/card_client_widget.dart';
import '../client_list/client_controller.dart';

class SearchClientPage extends GetView<SearchClientController> {
  const SearchClientPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColorScheme.background,
        appBar: AppBar(
          backgroundColor: AppColorScheme.appBarColor,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(AppSpacing.s16),
            child: Container(
              color: AppColorScheme.appBarColor,
              height: 0,
            ),
          ),
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back,
              color: AppColorScheme.background,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: AppSpacing.s16),
            child: TextFormField(
              controller: controller.searchController,
              onChanged: (value) {
                if (controller.debounce.value.isActive) controller.debounce.value.cancel();

                controller.debounce.value = Timer(
                  const Duration(milliseconds: 1000),
                  () async {
                    if (value.isNotEmpty && value.length >= 3) {
                      WidgetUtils.hideKeyboard(context);
                      await controller.onSearch(value);
                    } else {
                      controller.pageState.value = PageStateEnum.idle;
                    }
                  },
                );
              },
              decoration: InputDecoration(
                hintText: 'Buscar por nome do cliente',
                hintStyle: const TextStyle(color: AppColorScheme.inactiveText),
                filled: true,
                fillColor: AppColorScheme.bottomNavigatorColor,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => controller.clearSearch(),
                  icon: const Icon(Icons.close_outlined),
                  color: AppColorScheme.background,
                ),
              ),
              style: const TextStyle(color: AppColorScheme.background),
            ),
          ),
          centerTitle: true,
        ),
        body: GetBuilder(
          init: controller,
          builder: (_) => Obx(
            () {
              const ClientPageL10nImpl l10n = ClientPageL10nImpl();

              return Container(
                height: Get.height,
                width: Get.width,
                padding: const EdgeInsets.all(AppSpacing.s16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: AppSpacing.s16),
                    Text(
                      l10n.resultSearchClientMessage(controller.viewModel.value.clients.length),
                      style: TextStyle(
                        color: AppColorScheme.bodyText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: Constants.fontFamilyPoppins,
                      ),
                    ),
                    Obx(
                      () => switch (controller.pageState.value) {
                        PageStateEnum.loading => _buildLoading(),
                        PageStateEnum.error => _buildError(),
                        PageStateEnum.success => _buildSuccess(),
                        PageStateEnum.idle => const SizedBox.shrink(),
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  Widget _buildLoading() => const Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(
                color: AppColorScheme.buttonSuccess,
              ),
            ),
          ],
        ),
      );

  Widget _buildError() {
    const ClientPageL10nImpl l10n = ClientPageL10nImpl();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(SvgImages.icEmptyState),
          const SizedBox(height: AppSpacing.s24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
            child: Text(
              l10n.emptySearchClientMessage,
              style: TextStyle(
                color: AppColorScheme.secondaryText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.fontFamilyPoppins,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess() => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: AppSpacing.s4),
          shrinkWrap: true,
          itemCount: controller.viewModel.value.clients.length,
          itemBuilder: (context, index) {
            final client = controller.viewModel.value.clients[index];
            return CardClientWidget(
              client: client,
              onPressedDeleteClient: () async {
                const ClientPageL10nImpl l10n = ClientPageL10nImpl();
                await _buildAlert(context, l10n, client);
              },
              onPressedOpenClient: () {
                final clientController = Get.find<ClientController>();
                final argument = ClientArguments(
                  id: client.id.toString(),
                  name: client.name,
                  age: client.age,
                  city: client.city,
                  state: client.uf,
                  street: clientController.clients
                      .firstWhere((element) => int.parse(element.id) == client.id)
                      .address
                      .street,
                  neighborhood: clientController.clients
                      .firstWhere((element) => int.parse(element.id) == client.id)
                      .address
                      .neighborhood,
                  complement: '',
                  numberHome: clientController.clients
                          .firstWhere((element) => int.parse(element.id) == client.id)
                          .address
                          .numberHome ??
                      '',
                  referencePoint: clientController.clients
                          .firstWhere((element) => int.parse(element.id) == client.id)
                          .address
                          .referencePoint ??
                      '',
                );
                HomeAddClientPage.navigateWith(arguments: argument);
              },
              onPressedVisitClient: () {},
            );
          },
        ),
      );

  Future<void> _buildAlert(
    BuildContext context,
    ClientPageL10nImpl l10n,
    ClientListModel client,
  ) async =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColorScheme.background,
          title: _buildText(l10n.dialogDeleteClientTitle, fontSize: 22),
          content: _buildText(l10n.dialogDeleteClientMessage),
          actions: [
            _buildButton(
              Get.back,
              l10n.dialogOptionNoLabel,
              colorButton: AppColorScheme.optionColorButtonNo,
            ),
            _buildButton(
              () async {
                final clientController = Get.find<ClientController>();
                await clientController.deleteClient(client.id.toString());
                Get.back();
              },
              l10n.dialogOptionYesLabel,
            ),
          ],
        ),
      );

  Widget _buildButton(VoidCallback onPressed, String text, {Color? colorButton}) => TextButton(
        onPressed: onPressed,
        child: _buildText(
          text,
          color: colorButton ?? AppColorScheme.buttonSuccess,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildText(String text, {double? fontSize, Color? color, FontWeight? fontWeight}) => Text(
        text,
        style: TextStyle(
          color: color ?? AppColorScheme.bodyText,
          fontSize: fontSize ?? 14,
          fontFamily: Constants.fontFamilyPoppins,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      );
}
