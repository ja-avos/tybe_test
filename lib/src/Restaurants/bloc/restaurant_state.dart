part of "restaurant_cubit.dart";

class RestaurantState extends Equatable {
  final List<Restaurant> restaurants;
  final RequestStatus status;
  final String? error;

  const RestaurantState({
    this.restaurants = const [],
    this.status = RequestStatus.noSubmitted,
    this.error,
  });

  factory RestaurantState.initial() => const RestaurantState();

  factory RestaurantState.loading() =>
      const RestaurantState(status: RequestStatus.inProgress);

  factory RestaurantState.success(List<Restaurant> restaurants) =>
      RestaurantState(restaurants: restaurants, status: RequestStatus.success);

  factory RestaurantState.error(String error) =>
      RestaurantState(error: error, status: RequestStatus.failed);

  RestaurantState copyWith({
    List<Restaurant>? restaurants,
    RequestStatus? status,
    String? error,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        restaurants,
        status,
        error,
      ];
}
