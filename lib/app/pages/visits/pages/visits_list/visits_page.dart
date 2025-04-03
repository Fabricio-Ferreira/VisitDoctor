import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/visits/pages/visits_list/visits_controller.dart';
import 'package:visit_doctor/app/pages/visits/widgets/card_visit_widget.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../../../enum/page_state_enum.dart';

class VisitsPage extends GetView<VisitsController> {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColorScheme.background,
        body: GetBuilder(
          init: controller,
          initState: (state) => controller.getVisits(),
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
                        'Visitas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: Constants.fontFamilyPoppins,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Obx(
                    () => switch (controller.pageState.value) {
                      PageStateEnum.loading => _buildLoading(),
                      PageStateEnum.error => _buildError('Erro ao carregar as visitas'),
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(String errorText) => Center(
        child: Text(errorText),
      );

  Widget _buildBody() => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: AppSpacing.s4),
          shrinkWrap: true,
          itemCount: controller.viewModel.value.visits.length,
          itemBuilder: (context, index) {
            final visitItem = controller.viewModel.value.visits[index];

            return CardVisitWidget(visitItem: visitItem);
          },
        ),
      );
}
