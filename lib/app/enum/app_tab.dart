enum AppTab { home, clients, visits }

extension AppTabBuilder on AppTab {
  static AppTab build(int index) {
    switch (index) {
      case 0:
        return AppTab.home;
      case 1:
        return AppTab.clients;
      case 2:
        return AppTab.visits;

      default:
        return AppTab.home;
    }
  }
}
