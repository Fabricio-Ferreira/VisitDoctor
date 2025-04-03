import 'package:get/get.dart';
import 'package:visit_doctor/app/pages/clients/pages/search_client/search_client_page.dart';
import 'package:visit_doctor/app/pages/home/bindings/home_binding.dart';
import 'package:visit_doctor/app/pages/main/bindings/main_binding.dart';
import 'package:visit_doctor/app/pages/main/main_page.dart';
import 'package:visit_doctor/app/pages/splash/bindings/splash_binding.dart';
import 'package:visit_doctor/app/pages/splash/splash_page.dart';
import 'package:visit_doctor/app/pages/visits/bindings/visits_binding.dart';
import 'package:visit_doctor/app/pages/visits/pages/create_visit/create_visit_page.dart';
import 'package:visit_doctor/app/routes/route_enum.dart';

import '../pages/clients/bindings/clients_binding.dart';
import '../pages/clients/pages/client_list/client_page.dart';
import '../pages/home/pages/add_client/home_add_client_page.dart';
import '../pages/home/pages/home/home_page.dart';
import '../pages/visits/pages/visits_list/visits_page.dart';

mixin AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.home.path,
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.initial.path,
      transition: Transition.fadeIn,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.clients.path,
      transition: Transition.fadeIn,
      page: () => const ClientPage(),
      binding: ClientsBinding(),
    ),
    GetPage(
      name: Routes.visits.path,
      transition: Transition.fadeIn,
      page: () => const VisitsPage(),
      binding: VisitsBinding(),
    ),
    GetPage(
      name: Routes.main.path,
      transition: Transition.fadeIn,
      page: () => const MainPage(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        ClientsBinding(),
        VisitsBinding(),
      ],
    ),
    GetPage(
      name: Routes.addClient.path,
      transition: Transition.fadeIn,
      page: () => const HomeAddClientPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.searchClient.path,
      transition: Transition.fadeIn,
      page: () => const SearchClientPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.createVisit.path,
      transition: Transition.fadeIn,
      page: () => const CreateVisitPage(),
      binding: VisitsBinding(),
    ),
  ];
}
