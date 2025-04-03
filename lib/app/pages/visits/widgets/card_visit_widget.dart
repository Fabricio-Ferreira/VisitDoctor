import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/visits/view_model/visit_view_model.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../clients/pages/client_list/client_controller.dart';
import '../arguments/visit_arguments.dart';
import '../pages/create_visit/create_visit_page.dart';
import '../pages/visits_list/visits_controller.dart';

class CardVisitWidget extends GetView<VisitsController> {
  final VisitViewModel visitItem;

  const CardVisitWidget({
    required this.visitItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
        color: AppColorScheme.background,
        shadowColor: AppColorScheme.border,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(
                'Nome do cliente',
                fontSize: 10,
                color: AppColorScheme.secondaryText,
              ),
              const SizedBox(height: 4),
              _buildText(visitItem.name),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildText(
                          'Motivo da visita',
                          fontSize: 10,
                          color: AppColorScheme.secondaryText,
                        ),
                        const SizedBox(height: 4),
                        _buildText(visitItem.reasonVisit),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildText(
                          'Data da visita',
                          fontSize: 10,
                          color: AppColorScheme.secondaryText,
                        ),
                        const SizedBox(height: 4),
                        _buildText(visitItem.dateVisit),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s20),
              Row(
                children: [
                  IconButton(
                    onPressed: () async => _buildAlert(context, visitItem),
                    icon: const Icon(
                      Icons.delete,
                      color: AppColorScheme.error,
                      size: AppSpacing.s32,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorScheme.buttonSuccess,
                    ),
                    onPressed: () {
                      final clientController = Get.find<ClientController>();
                      final client = clientController.viewModel.value.clients.firstWhere(
                        (element) => element.id == visitItem.clientId,
                      );

                      final arguments = VisitArguments(
                        id: visitItem.visitId.toString(),
                        name: visitItem.name,
                        age: client.age,
                        city: client.city,
                        state: client.uf,
                        reasonVisit: visitItem.reasonVisit,
                        observationVisit: visitItem.observation,
                        dateVisit: visitItem.dateVisit,
                      );

                      CreateVisitPage.navigateWith(arguments: arguments);
                    },
                    child: _buildText(
                      'Visualizar',
                      color: AppColorScheme.background,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Future<void> _buildAlert(
    BuildContext context,
    VisitViewModel model,
  ) async =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColorScheme.background,
          title: _buildText('Apagar visita', fontSize: 22),
          content: _buildText('Você tem certeza que deseja apagar este cliente?'),
          actions: [
            _buildButton(
              Get.back,
              'Não',
              colorButton: AppColorScheme.optionColorButtonNo,
            ),
            _buildButton(
              () async {
                Get.back();
                await controller.deleteVisit(model.visitId.toString());
              },
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
        ),
      );

  Widget _buildText(String text, {double? fontSize, Color? color}) => Text(
        text,
        style: TextStyle(
          color: color ?? AppColorScheme.bodyText,
          fontSize: fontSize ?? 14,
          fontFamily: Constants.fontFamilyPoppins,
          fontWeight: FontWeight.w500,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<VisitViewModel>('visitItem', visitItem));
  }
}
