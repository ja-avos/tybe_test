import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_test/src/Orders/bloc/transaction_cubit.dart';
import 'package:tyba_test/src/Orders/repository/transaction_repository.dart';
import 'package:tyba_test/src/Restaurants/bloc/restaurant_cubit.dart';
import 'package:tyba_test/src/Restaurants/repository/restaurant_repository.dart';
import 'package:tyba_test/src/User/bloc/user_cubit.dart';
import 'package:tyba_test/src/User/repository/user_repository.dart';
import 'package:tyba_test/src/settings/router.dart' as router;
import 'package:tyba_test/src/settings/routes.dart';

/// The Widget that configures your application.
class TybaTestApp extends StatelessWidget {
  const TybaTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<RestaurantRepository>(
          create: (context) => RestaurantRepository(),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (context) => TransactionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
              RepositoryProvider.of<UserRepository>(context),
            )..checkSession(),
          ),
          BlocProvider<RestaurantCubit>(
            create: (context) => RestaurantCubit(
              RepositoryProvider.of<RestaurantRepository>(context),
            ),
          ),
          BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(
              RepositoryProvider.of<TransactionRepository>(context),
            ),
          ),
        ],
        child: const MaterialApp(
          restorationScopeId: 'tyba_test_app',
          onGenerateRoute: router.onGenerateRoute,
          initialRoute: Routes.login,
        ),
      ),
    );
  }
}
