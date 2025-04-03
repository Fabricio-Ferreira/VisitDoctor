import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/home/pages/home/home_controller.dart';
import 'package:visit_doctor/app/pages/home/widgets/card_info_address_widget.dart';
import 'package:visit_doctor/app/shared/widgets/app_input_text.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../../../enum/page_state_enum.dart';
import '../../../../utils/mask_text_input_formatter.dart';
import '../../l10n/home_page_l10n_impl.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const HomePageL10nImpl homePageL10n = HomePageL10nImpl();

    return Scaffold(
      backgroundColor: AppColorScheme.background,
      body: GetBuilder(
        init: controller,
        builder: (_) => Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.s16,
            AppSpacing.s24 + MediaQuery.of(context).padding.top,
            AppSpacing.s16,
            AppSpacing.s24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppInputText(
                titleInput: homePageL10n.labelCep,
                hintInput: homePageL10n.hintCep,
                textController: controller.cepTextController,
                onChanged: controller.onChanged,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                  maskTextInputFormatterPostalCode,
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSpacing.s24),
              Obx(
                () => SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: controller.stateButton.value == WidgetState.disabled
                        ? null
                        : () async => controller.getAddressByCep(),
                    statesController: WidgetStatesController(
                      <WidgetState>{WidgetState.selected, WidgetState.disabled},
                    ),
                    style: ButtonStyle(
                      backgroundBuilder: (context, states, child) {
                        if (states.contains(WidgetState.disabled)) {
                          return Container(
                            color: AppColorScheme.buttonDisabled,
                            child: Center(
                              child: Obx(
                                () => Text(
                                  controller.pageState.value == PageStateEnum.success
                                      ? homePageL10n.buttonConfirm
                                      : homePageL10n.buttonSearchLabel,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColorScheme.inactiveText,
                                    fontFamily: Constants.fontFamilyPoppins,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (controller.pageState.value == PageStateEnum.loading) {
                          return _buildLoading();
                        }
                        return Container(
                          color: AppColorScheme.buttonSuccess,
                          child: Center(
                            child: Text(
                              homePageL10n.buttonSearchLabel,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColorScheme.background,
                                fontFamily: Constants.fontFamilyPoppins,
                              ),
                            ),
                          ),
                        );
                      },
                      textStyle: WidgetStateProperty.all(
                        TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColorScheme.background,
                          fontFamily: Constants.fontFamilyPoppins,
                        ),
                      ),
                    ),
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              Obx(
                () {
                  final model = controller.viewModel.value;
                  return controller.pageState.value == PageStateEnum.success &&
                          model.city.isNotEmpty
                      ? CardInfoAddressWidget(model: model)
                      : const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => Container(
        color: AppColorScheme.buttonSuccess,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(6),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColorScheme.background,
              ),
            ),
          ),
        ),
      );
}
