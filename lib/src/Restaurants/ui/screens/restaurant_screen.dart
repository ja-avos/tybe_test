import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_test/src/Restaurants/bloc/restaurant_cubit.dart';
import 'package:tyba_test/src/Restaurants/models/restaurant_model.dart';
import 'package:tyba_test/src/Restaurants/ui/widgets/restaurant_card.dart';
import 'package:tyba_test/src/Restaurants/ui/widgets/search_box.dart';
import 'package:tyba_test/src/utils/request_status.dart';
import 'package:tyba_test/src/utils/widgets/loading.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  Widget buildResults(BuildContext context, List<Restaurant> restaurants) {
    if (restaurants.isEmpty) {
      return Center(
        child: Text('No hay resultados :(',
            style: Theme.of(context).textTheme.headline6),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurants.length,
            itemBuilder: (context, index) => RestaurantCard(
              restaurants[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          'Restaurants',
          style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 40),
        ),
        const SizedBox(height: 40),
        SearchBox(),
        Expanded(
          child: BlocBuilder<RestaurantCubit, RestaurantState>(
            builder: (context, state) {
              if (state.status == RequestStatus.inProgress) {
                return const Loading();
              }
              if (state.status == RequestStatus.success) {
                return buildResults(context, state.restaurants);
              }
              if (state.status == RequestStatus.failed) {
                return Center(child: Text("Error: ${state.error}"));
              }
              return const Center(
                  child: Text(
                      "Escribe la ciudad donde quieres buscar restaurante."));
            },
          ),
        ),
      ],
    );
  }
}
