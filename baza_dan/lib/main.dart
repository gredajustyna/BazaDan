import 'package:baza_dan/src/config/routes/app_routes.dart';
import 'package:baza_dan/src/config/themes/app_themes.dart';
import 'package:baza_dan/src/core/utils/constants.dart';
import 'package:baza_dan/src/presentation/blocs/check_email_bloc/check_email_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/edit_user_bloc/edit_user_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_orders_bloc/get_orders_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_random_food_bloc/get_random_food_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_reservations_bloc/get_reservations_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_tables_bloc/get_tables_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/reserve_bloc/reserve_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(
        create: (_) => injector<LoginBloc>(),
      ),
      BlocProvider<RegisterBloc>(
        create: (_) => injector<RegisterBloc>(),
      ),
      BlocProvider<CheckEmailBloc>(
        create: (_) => injector<CheckEmailBloc>(),
      ),
      BlocProvider<FastFoodBloc>(
        create: (_) => injector<FastFoodBloc>(),
      ),
      BlocProvider<BurgerBloc>(
        create: (_) => injector<BurgerBloc>(),
      ),
      BlocProvider<DishListBloc>(
        create: (_) => injector<DishListBloc>(),
      ),
      BlocProvider<PizzaBloc>(
        create: (_) => injector<PizzaBloc>(),
      ),
      BlocProvider<PastaListBloc>(
        create: (_) => injector<PastaListBloc>(),
      ),
      BlocProvider<ExtrasBloc>(
        create: (_) => injector<ExtrasBloc>(),
      ),
      BlocProvider<DrinksBloc>(
        create: (_) => injector<DrinksBloc>(),
      ),
      BlocProvider<OrderBloc>(
        create: (_) => injector<OrderBloc>(),
      ),
      BlocProvider<EditUserBloc>(
        create: (_) => injector<EditUserBloc>(),
      ),
      BlocProvider<GetRandomFoodBloc>(
        create: (_) => injector<GetRandomFoodBloc>(),
      ),
      BlocProvider<GetOrdersBloc>(
        create: (_) => injector<GetOrdersBloc>(),
      ),
      BlocProvider<GetDetailsBloc>(
        create: (_) => injector<GetDetailsBloc>(),
      ),
      BlocProvider<GetTablesBloc>(
        create: (_) => injector<GetTablesBloc>(),
      ),
      BlocProvider<ReserveBloc>(
        create: (_) => injector<ReserveBloc>(),
      ),
      BlocProvider<GetReservationsBloc>(
        create: (_) => injector<GetReservationsBloc>(),
      ),
    ],
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDependencies();
    return MaterialApp(
      title: kMaterialAppTitle,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
    );
  }

}

