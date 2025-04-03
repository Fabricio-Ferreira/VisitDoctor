import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:visit_doctor/app/app_binding.dart';
import 'package:visit_doctor/app/routes/app_routes.dart';
import 'package:visit_doctor/app/styles/app_color_scheme.dart';
import 'package:visit_doctor/app/utils/constants.dart';
import 'package:visit_doctor/app/utils/widget_utils.dart';

import 'routes/route_enum.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initial.path,
        getPages: AppRoutes.routes,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        theme: ThemeData(
          primarySwatch: AppColorScheme.primarySwatch,
          scaffoldBackgroundColor: AppColorScheme.background,
          fontFamily: Constants.fontFamilyPoppins,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: AppColorScheme.appBarColor,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
              ),
        ),
        initialBinding: AppBinding(),
        builder: (context, child) => LayoutBuilder(
          builder: (context, constraints) {
            const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
              statusBarColor: AppColorScheme.primary,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: AppColorScheme.bottomNavigatorColor,
              systemNavigationBarIconBrightness: Brightness.light,
            );
            SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

            return GestureDetector(
              onTap: () => WidgetUtils.hideKeyboard(context),
              child: child,
            );
          },
        ),
      );
}
