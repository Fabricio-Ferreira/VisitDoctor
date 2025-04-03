import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visit_doctor/app/pages/clients/view_model/client_list_view_model.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/styles/app_spacing.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../l10n/client_page_l10n_impl.dart';

class CardClientWidget extends StatelessWidget {
  const CardClientWidget({
    required this.client,
    this.onPressedDeleteClient,
    this.onPressedOpenClient,
    this.onPressedVisitClient,
    this.showButtons = true,
    super.key,
  });

  final ClientListModel client;
  final VoidCallback? onPressedDeleteClient;
  final VoidCallback? onPressedOpenClient;
  final VoidCallback? onPressedVisitClient;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    const ClientPageL10nImpl l10n = ClientPageL10nImpl();
    const spacing4 = SizedBox(height: 4);
    const spacing12 = SizedBox(height: 12);

    return Card(
      color: AppColorScheme.background,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(l10n.clientNameLabel),
                    spacing4,
                    _buildClientValue(client.name),
                    spacing12,
                    _buildTitle(l10n.clientCityLabel),
                    spacing4,
                    _buildClientValue(client.city),
                  ],
                ),
                const Spacer(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(l10n.clientAgeLabel),
                      spacing4,
                      _buildClientValue(client.age.toString()),
                      spacing12,
                      _buildTitle(l10n.clientStateLabel),
                      spacing4,
                      _buildClientValue(client.uf),
                    ],
                  ),
                ),
              ],
            ),
            if (showButtons) ...[
              const SizedBox(height: AppSpacing.s20),
              Row(
                children: [
                  IconButton(
                    onPressed: onPressedDeleteClient,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColorScheme.error,
                      size: AppSpacing.s32,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorScheme.secondary,
                    ),
                    onPressed: onPressedVisitClient,
                    child: _buildClientValue(l10n.clientVisitButtonLabel),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorScheme.buttonSuccess,
                    ),
                    onPressed: onPressedOpenClient,
                    child: _buildClientValue(
                      l10n.clientOpenButtonLabel,
                      AppColorScheme.background,
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) => Text(
        title,
        style: TextStyle(
          color: AppColorScheme.secondaryText,
          fontSize: 10,
          fontFamily: Constants.fontFamilyPoppins,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildClientValue(String value, [Color? colorButton]) => Text(
        value,
        style: TextStyle(
          color: colorButton ?? AppColorScheme.bodyText,
          fontSize: 14,
          fontFamily: Constants.fontFamilyPoppins,
          fontWeight: FontWeight.w500,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ClientListModel>('client', client));
    properties
        .add(ObjectFlagProperty<VoidCallback?>.has('onPressedOpenClient', onPressedOpenClient));
    properties
        .add(ObjectFlagProperty<VoidCallback?>.has('onPressedDeleteClient', onPressedDeleteClient));
    properties
        .add(ObjectFlagProperty<VoidCallback?>.has('onPressedVisitClient', onPressedVisitClient));
    properties.add(DiagnosticsProperty<bool>('showButtons', showButtons));
  }
}
