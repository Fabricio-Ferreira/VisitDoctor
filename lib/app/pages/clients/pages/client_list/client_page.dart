import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/clients/pages/client_list/client_controller.dart';
import 'package:visit_doctor/app/pages/clients/view_model/client_list_view_model.dart';
import 'package:visit_doctor/app/pages/clients/widgets/card_client_widget.dart';
import 'package:visit_doctor/app/pages/home/pages/add_client/home_add_client_page.dart';
import 'package:visit_doctor/app/pages/visits/pages/create_visit/create_visit_page.dart';
import 'package:visit_doctor/app/routes/route_enum.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../../../enum/page_state_enum.dart';
import '../../../home/arguments/client_arguments.dart';
import '../../../visits/arguments/visit_arguments.dart';
import '../../l10n/client_page_l10n_impl.dart';

class ClientPage extends GetView<ClientController> {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    const ClientPageL10nImpl l10n = ClientPageL10nImpl();

    return Scaffold(
      backgroundColor: AppColorScheme.background,
      body: GetBuilder(
        init: controller,
        initState: (state) => controller.getAllClients(),
        builder: (_) => SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.s16,
              AppSpacing.s16 + MediaQuery.of(context).padding.top,
              AppSpacing.s16,
              AppSpacing.s16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.clients,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: Constants.fontFamilyPoppins,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.toNamed(Routes.searchClient.path),
                      icon: const Icon(Icons.search_outlined),
                    ),
                  ],
                ),
                const Divider(),
                Obx(
                  () => switch (controller.pageState.value) {
                    PageStateEnum.loading => _buildLoading(),
                    PageStateEnum.error => _buildError(l10n.errorLoadingClients),
                    PageStateEnum.success => _buildBody(),
                    PageStateEnum.idle => const SizedBox.shrink(),
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String errorText) => Center(
        child: Text(errorText),
      );

  Widget _buildBody() => Expanded(
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
                client.hasVisit
                    ? await _buildAlert(context, l10n, client)
                    : await _buildAlertNoContentVisit(context, client);
              },
              onPressedVisitClient: () {
                final arguments = VisitArguments(
                  id: client.id.toString(),
                  name: client.name,
                  age: client.age,
                  city: client.city,
                  state: client.uf,
                  reasonVisit: '',
                  observationVisit: '',
                  dateVisit: '',
                );

                CreateVisitPage.navigateWith(arguments: arguments);
              },
              onPressedOpenClient: () {
                final argument = ClientArguments(
                  id: client.id.toString(),
                  name: client.name,
                  age: client.age,
                  city: client.city,
                  state: client.uf,
                  street: controller.clients
                      .firstWhere((element) => int.parse(element.id) == client.id)
                      .address
                      .street,
                  neighborhood: controller.clients
                      .firstWhere((element) => int.parse(element.id) == client.id)
                      .address
                      .neighborhood,
                  complement: '',
                  numberHome: controller.clients
                          .firstWhere((element) => int.parse(element.id) == client.id)
                          .address
                          .numberHome ??
                      '',
                  referencePoint: controller.clients
                          .firstWhere((element) => int.parse(element.id) == client.id)
                          .address
                          .referencePoint ??
                      '',
                  hasVisit: controller.clients
                              .firstWhere((element) => int.parse(element.id) == client.id)
                              .hasVisit ==
                          true
                      ? 'true'
                      : 'false',
                );
                HomeAddClientPage.navigateWith(arguments: argument);
              },
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
                await controller.deleteClient(client.id.toString());
                Get.back();
              },
              l10n.dialogOptionYesLabel,
            ),
          ],
        ),
      );

  Future<void> _buildAlertNoContentVisit(
    BuildContext context,
    ClientListModel client,
  ) async =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColorScheme.background,
          title: _buildText('Apagar cliente', fontSize: 22),
          content: _buildText('Você tem certeza que deseja apagar este cliente?'),
          actions: [
            _buildButton(
              Get.back,
              'Não',
              colorButton: AppColorScheme.optionColorButtonNo,
            ),
            _buildButton(
              () async => controller.deleteClient(client.id.toString()),
              'Sim',
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
