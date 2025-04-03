import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/clients/widgets/card_client_widget.dart';
import 'package:visit_doctor/app/pages/visits/pages/create_visit/create_visit_controller.dart';
import 'package:visit_doctor/app/shared/widgets/app_input_text.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../../../routes/route_enum.dart';
import '../../../../styles/app_color_scheme.dart';
import '../../arguments/visit_arguments.dart';
import '../../widgets/custom_date_picker.dart';

class CreateVisitPage extends GetView<CreateVisitController> {
  static void navigateWith({required VisitArguments? arguments}) {
    Get.toNamed(Routes.createVisit.path, arguments: arguments);
  }

  const CreateVisitPage({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: controller,
        initState: (_) => controller.init(),
        builder: (context) => Scaffold(
          backgroundColor: AppColorScheme.background,
          appBar: AppBar(
            titleSpacing: 0,
            elevation: 4,
            title: Text(
              'Cadastro de visita',
              style: TextStyle(
                color: AppColorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: Constants.fontFamilyPoppins,
              ),
            ),
            backgroundColor: AppColorScheme.background,
            forceMaterialTransparency: true,
          ),
          bottomNavigationBar: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  height: 40,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isButtonDisabled.value ? _onPressed : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(controller.isButtonDisabled.value
                            ? AppColorScheme.buttonSuccess
                            : AppColorScheme.buttonDisabled),
                      ),
                      child: Text(
                        'Confirmar Cadastro',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: controller.isButtonDisabled.value
                              ? AppColorScheme.background
                              : AppColorScheme.inactiveText,
                          fontFamily: Constants.fontFamilyPoppins,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.s16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    final client = controller.client.value;
                    return CardClientWidget(
                      client: client,
                      showButtons: false,
                    );
                  }),
                  const SizedBox(height: AppSpacing.s16),
                  Obx(
                    () => AppInputText(
                      titleInput: 'Motivo da visita',
                      hintInput: 'Selecione o motivo',
                      textController: controller.reasonVisitTextController,
                      onChanged: controller.onChangedReasonVisit,
                      suffixIcon: IconButton(
                        icon: Icon(controller.isDropdownOpen.value
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined),
                        onPressed: () => controller.isDropdownOpen.toggle(),
                      ),
                      isDropdownOpen: controller.isDropdownOpen.value,
                      readOnly: true,
                      onTap: () => controller.isDropdownOpen.toggle(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  const CustomDatePicker(restorationId: 'main'),
                  const SizedBox(height: AppSpacing.s16),
                  AppInputText(
                    titleInput: 'Observações',
                    hintInput: 'Registre suas observações',
                    textController: controller.observationTextController,
                    isOptional: true,
                    onChanged: controller.onChangedObservation,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> _onPressed() async => controller.onPressed();
}
