import 'core/modules/local_module.dart';
import 'core/modules/remote_module.dart';

Future<void> initCoreModules() async {
  RemoteModule.init();
  await LocalModule.init();
}
