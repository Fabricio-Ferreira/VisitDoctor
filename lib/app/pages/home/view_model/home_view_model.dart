class HomeViewModel {
  final String street;
  final String neighborhood;
  final String city;
  final String state;

  HomeViewModel({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  HomeViewModel copyWith({
    String? street,
    String? neighborhood,
    String? city,
    String? state,
  }) =>
      HomeViewModel(
        street: street ?? this.street,
        neighborhood: neighborhood ?? this.neighborhood,
        city: city ?? this.city,
        state: state ?? this.state,
      );
}
