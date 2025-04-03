class VisitListViewModel {
  final List<VisitViewModel> visits;

  VisitListViewModel({required this.visits});

  VisitListViewModel copyWith({
    List<VisitViewModel>? visits,
  }) =>
      VisitListViewModel(
        visits: visits ?? this.visits,
      );
}

class VisitViewModel {
  final int visitId;
  final String name;
  final String dateVisit;
  final String reasonVisit;
  final String observation;
  final int clientId;

  VisitViewModel({
    required this.visitId,
    required this.name,
    required this.dateVisit,
    required this.reasonVisit,
    required this.observation,
    required this.clientId,
  });
}
