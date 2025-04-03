import 'dart:async';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';
import 'init_core_modules.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initCoreModules();

      runApp(const AppWidget());
    },
    (error, stackTrace) {
      debugPrint('runzonedGuarded: Caught error: $error');
      debugPrint('runzonedGuarded: StackTrace: $stackTrace');
    },
  );
}
