import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_doctor/app/images/svg/svg_images.dart';
import 'package:visit_doctor/app/pages/main/main_controller.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';

import '../../enum/app_tab.dart';
import 'model/bottom_navigator_bar_item_model.dart';
import 'widgets/bottom_navigator_bar_widget.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColorScheme.background,
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
        ),
        bottomNavigationBar: Container(
          height: 100,
          decoration: const BoxDecoration(color: AppColorScheme.bottomNavigatorColor),
          child: GetBuilder<MainController>(
            builder: (_) => Obx(
              () => BottomNavigationBarWidget(
                items: const [
                  BottomNavigationBarItemModel(
                    assetSvgImages: SvgImages.icHome,
                    label: 'Início',
                  ),
                  BottomNavigationBarItemModel(
                    assetSvgImages: SvgImages.icClient,
                    label: 'Clientes',
                  ),
                  BottomNavigationBarItemModel(
                    assetSvgImages: SvgImages.icVisit,
                    label: 'Visitas',
                  ),
                ],
                currentIndex: controller.currentIndex,
                onTap: _changeBottomBarNavigationIndex,
              ),
            ),
          ),
        ),
      );

  void _changeBottomBarNavigationIndex(int index) =>
      controller.changePage(AppTabBuilder.build(index));
}
