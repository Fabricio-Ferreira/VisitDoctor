import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visit_doctor/app/utils/constants.dart';

import '../../../styles/app_color_scheme.dart';
import '../../../styles/app_spacing.dart';
import '../model/bottom_navigator_bar_item_model.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final List<BottomNavigationBarItemModel> items;

  const BottomNavigationBarWidget({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  Widget build(BuildContext context) => BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColorScheme.bottomNavigatorColor,
        selectedItemColor: AppColorScheme.background,
        unselectedItemColor: AppColorScheme.background,
        selectedIconTheme: const IconThemeData(color: AppColorScheme.background),
        unselectedIconTheme: const IconThemeData(color: AppColorScheme.background),
        selectedLabelStyle: TextStyle(
          color: AppColorScheme.background,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: Constants.fontFamilyRoboto,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColorScheme.background,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: Constants.fontFamilyRoboto,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        items: items
            .map(
              (e) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s4, top: AppSpacing.s4),
                  child: SvgPicture.asset(
                    e.assetSvgImages,
                    height: 24,
                    width: 24,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s4, top: AppSpacing.s4),
                  child: Container(
                    width: 64,
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColorScheme.primary,
                    ),
                    child: SvgPicture.asset(
                      e.assetSvgImages,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                label: e.label,
              ),
            )
            .toList(),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('currentIndex', currentIndex));
    properties.add(ObjectFlagProperty<Function(int p1)?>.has('onTap', onTap));
    properties.add(IterableProperty<BottomNavigationBarItemModel>('items', items));
  }
}
