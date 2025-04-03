import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visit_doctor/app/pages/home/pages/add_client/home_add_client_page.dart';
import 'package:visit_doctor/app/pages/home/view_model/home_view_model.dart';

import '../../../styles/app_color_scheme.dart';
import '../../../styles/app_spacing.dart';
import '../../../utils/constants.dart';
import '../l10n/home_page_l10n_impl.dart';

class CardInfoAddressWidget extends StatelessWidget {
  const CardInfoAddressWidget({
    required this.model,
    this.showButton = true,
    super.key,
  });

  final HomeViewModel model;
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    const HomePageL10nImpl homePageL10n = HomePageL10nImpl();

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: AppColorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoAddressCard(title: homePageL10n.streetLabel, value: model.street),
            _buildInfoAddressCard(title: homePageL10n.neighborhoodLabel, value: model.neighborhood),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildInfoAddressCard(title: homePageL10n.cityLabel, value: model.city),
                ),
                const SizedBox(width: AppSpacing.s16),
                Expanded(
                  child: _buildInfoAddressCard(title: homePageL10n.stateLabel, value: model.state),
                ),
              ],
            ),
            if (showButton!) ...[
              const SizedBox(height: AppSpacing.s24 + AppSpacing.s4),
              ElevatedButton(
                onPressed: () => HomeAddClientPage.navigateWith(arguments: null),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColorScheme.secondary),
                ),
                child: Text(
                  homePageL10n.buttonAddClientToAddressLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColorScheme.bodyText,
                    fontFamily: Constants.fontFamilyPoppins,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildInfoAddressCard({required String title, required String value}) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColorScheme.secondaryText,
              fontFamily: Constants.fontFamilyPoppins,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.s4, bottom: AppSpacing.s8),
            child: Text(value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColorScheme.bodyText,
                  fontFamily: Constants.fontFamilyPoppins,
                )),
          ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<HomeViewModel>('model', model));
    properties.add(DiagnosticsProperty<bool?>('showButton', showButton));
  }
}
