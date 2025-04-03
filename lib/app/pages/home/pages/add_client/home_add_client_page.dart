import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/home/pages/home/home_controller.dart';
import 'package:visit_doctor/app/pages/home/widgets/card_info_address_widget.dart';
import 'package:visit_doctor/app/routes/route_enum.dart';
import 'package:visit_doctor/app/shared/widgets/app_input_text.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../../../styles/app_spacing.dart';
import '../../arguments/client_arguments.dart';

class HomeAddClientPage extends GetView<HomeController> {
  static void navigateWith({required ClientArguments? arguments}) {
    Get.toNamed(Routes.addClient.path, arguments: arguments);
  }

  const HomeAddClientPage({super.key});

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
              'Cadasto de cliente',
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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardInfoAddressWidget(
                    model: controller.viewModel.value,
                    showButton: false,
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  AppInputText(
                    titleInput: 'Nome do cliente',
                    hintInput: 'Nome Completo',
                    textController: controller.nameTextController,
                    textCapitalization: TextCapitalization.words,
                    onChanged: controller.onChangedName,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  AppInputText(
                    titleInput: 'Idade',
                    hintInput: 'Insira a idade em números',
                    textController: controller.ageTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: controller.onChangedAge,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  AppInputText(
                    titleInput: 'N° da residência',
                    hintInput: 'Insira o número da residência',
                    textController: controller.numberHomeTextController,
                    keyboardType: TextInputType.number,
                    onChanged: controller.onChangedNumberHome,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  AppInputText(
                    titleInput: 'Ponto de referência',
                    hintInput: 'Insira um ponto de referência',
                    textController: controller.referencePointTextController,
                    isOptional: true,
                    onChanged: controller.onChangedPointReference,
                  ),
                ],
              ),
            ),
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
                        controller.args != null ? 'Salvar alteração' : 'Confirmar Cadastro',
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
        ),
      );

  Future<void> _onPressed() async => controller.onPressed();
}
