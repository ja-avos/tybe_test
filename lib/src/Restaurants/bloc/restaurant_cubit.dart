import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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

  void searchRestaurantGPS() async {
    emit(RestaurantState.loading());
    try {
      final position = await _determinePosition();
      final restaurants = await repository.getRestaurantsGPS(
          position.latitude, position.longitude);
      emit(RestaurantState.success(restaurants));
    } catch (e) {
      emit(RestaurantState.error(e.toString()));
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
