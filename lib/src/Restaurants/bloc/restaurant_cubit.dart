import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tyba_test/src/Restaurants/models/restaurant_model.dart';
import 'package:tyba_test/src/Restaurants/repository/restaurant_repository.dart';
import 'package:tyba_test/src/utils/request_status.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository repository;

  RestaurantCubit(this.repository) : super(RestaurantState.initial());

  void searchRestaurantCity(String location) async {
    emit(RestaurantState.loading());
    try {
      final restaurants = await repository.getRestaurants(location);
      emit(RestaurantState.success(restaurants));
    } catch (e) {
      emit(RestaurantState.error(e.toString()));
    }
  }

  void searchRestaurantGPS(double lat, double lng) async {
    emit(RestaurantState.loading());
    try {
      final restaurants = await repository.getRestaurantsGPS(lat, lng);
      emit(RestaurantState.success(restaurants));
    } catch (e) {
      emit(RestaurantState.error(e.toString()));
    }
  }
}
