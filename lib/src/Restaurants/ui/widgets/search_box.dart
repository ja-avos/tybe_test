import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_test/src/Restaurants/bloc/restaurant_cubit.dart';

class SearchBox extends StatelessWidget {
  SearchBox({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        onChanged: (value) {
          BlocProvider.of<RestaurantCubit>(context).searchRestaurantCity(value);
        },
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: InkWell(
            onTap: () {
              if (_searchController.text.isNotEmpty) {
                BlocProvider.of<RestaurantCubit>(context)
                    .searchRestaurantCity(_searchController.text);
              }
            },
            child: const Icon(Icons.search),
          ),
          suffixIcon: InkWell(
            onTap: () {
              _searchController.clear();
              BlocProvider.of<RestaurantCubit>(context).searchRestaurantGPS();
            },
            child: const Icon(Icons.location_on),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Search',
        ),
      ),
    );
  }
}
