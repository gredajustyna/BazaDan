import 'package:baza_dan/src/data/repositories/food_repository_impl.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';
import 'package:baza_dan/src/domain/usecases/check_email_usecase.dart';
import 'package:baza_dan/src/domain/usecases/edit_user_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_food_list_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_order_details_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_orders_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_random_food_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_reservations_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_tables_usecase.dart';
import 'package:baza_dan/src/domain/usecases/login_usecase.dart';
import 'package:baza_dan/src/domain/usecases/order_usecase.dart';
import 'package:baza_dan/src/domain/usecases/register_usecase.dart';
import 'package:baza_dan/src/domain/usecases/reserve_table_usecase.dart';
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
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {

  injector.registerSingleton<FoodRepository>(FoodRepositoryImpl());

  injector.registerSingleton<LoginUseCase>(LoginUseCase(injector()));
  injector.registerSingleton<RegisterUseCase>(RegisterUseCase(injector()));
  injector.registerSingleton<CheckEmailUseCase>(CheckEmailUseCase(injector()));
  injector.registerSingleton<GetFoodListUseCase>(GetFoodListUseCase(injector()));
  injector.registerSingleton<OrderUseCase>(OrderUseCase(injector()));
  injector.registerSingleton<EditUserUseCase>(EditUserUseCase(injector()));
  injector.registerSingleton<GetRandomFoodUseCase>(GetRandomFoodUseCase(injector()));
  injector.registerSingleton<GetOrdersUseCase>(GetOrdersUseCase(injector()));
  injector.registerSingleton<GetOrderDetailsUseCase>(GetOrderDetailsUseCase(injector()));
  injector.registerSingleton<GetTablesUseCase>(GetTablesUseCase(injector()));
  injector.registerSingleton<ReserveTableUseCase>(ReserveTableUseCase(injector()));
  injector.registerSingleton<GetReservationsUseCase>(GetReservationsUseCase(injector()));

  injector.registerFactory<LoginBloc>(() => LoginBloc(injector()));
  injector.registerFactory<RegisterBloc>(() => RegisterBloc(injector(), injector()));
  injector.registerFactory<CheckEmailBloc>(() => CheckEmailBloc(injector()));
  injector.registerFactory<FastFoodBloc>(() => FastFoodBloc(injector()));
  injector.registerFactory<DishListBloc>(() => DishListBloc(injector()));
  injector.registerFactory<BurgerBloc>(() => BurgerBloc(injector()));
  injector.registerFactory<PastaListBloc>(() => PastaListBloc(injector()));
  injector.registerFactory<PizzaBloc>(() => PizzaBloc(injector()));
  injector.registerFactory<ExtrasBloc>(() => ExtrasBloc(injector()));
  injector.registerFactory<DrinksBloc>(() => DrinksBloc(injector()));
  injector.registerFactory<OrderBloc>(() => OrderBloc(injector()));
  injector.registerFactory<EditUserBloc>(() => EditUserBloc(injector()));
  injector.registerFactory<GetRandomFoodBloc>(() => GetRandomFoodBloc(injector()));
  injector.registerFactory<GetOrdersBloc>(() => GetOrdersBloc(injector()));
  injector.registerFactory<GetDetailsBloc>(() => GetDetailsBloc(injector()));
  injector.registerFactory<GetTablesBloc>(() => GetTablesBloc(injector()));
  injector.registerFactory<ReserveBloc>(() => ReserveBloc(injector()));
  injector.registerFactory<GetReservationsBloc>(() => GetReservationsBloc(injector()));
}