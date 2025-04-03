enum Routes {
  home('/home'),
  initial('/'),
  clients('/clients'),
  main('/main'),
  visits('/visits'),
  searchClient('/search-clients'),
  createVisit('/create-visit'),
  addClient('/addClient');

  final String path;

  const Routes(this.path);
}
