import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_test/src/Restaurants/bloc/restaurant_cubit.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        onChanged: (value) {
          BlocProvider.of<RestaurantCubit>(context).searchRestaurantCity(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: InkWell(
            onTap: () => print("Search"),
            child: const Icon(Icons.search),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Search',
        ),
      ),
    );
  }
}
