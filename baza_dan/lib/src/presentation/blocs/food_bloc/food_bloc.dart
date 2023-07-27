import 'package:baza_dan/src/domain/usecases/get_food_list_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_event.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FastFoodBloc extends Bloc<FoodEvent, FastFoodState>{
  final GetFoodListUseCase _getFoodListUseCase;
  FastFoodBloc(this._getFoodListUseCase): super(const FastListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _fastFoodHandler(emit, event.category!);
    });
  }

  Future<void> _fastFoodHandler(Emitter<FastFoodState> emit, String params) async {
    emit(const FastListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(FastListDone(result));
    }else{
      emit(const FastListError());
    }
  }
}

class BurgerBloc extends Bloc<FoodEvent, BurgerState>{
  final GetFoodListUseCase _getFoodListUseCase;
  BurgerBloc(this._getFoodListUseCase): super(const BurgerListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _burgerHandler(emit, event.category!);
    });
  }

  Future<void> _burgerHandler(Emitter<BurgerState> emit, String params) async {
    emit(const BurgerListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(BurgerListDone(result));
    }else{
      emit(const BurgerListError());
    }
  }
}

class DishListBloc extends Bloc<FoodEvent, DishState>{
  final GetFoodListUseCase _getFoodListUseCase;
  DishListBloc(this._getFoodListUseCase): super(const DishListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _dishHandler(emit, event.category!);
    });
  }

  Future<void> _dishHandler(Emitter<DishState> emit, String params) async {
    emit(const DishListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(DishListDone(result));
    }else{
      emit(const DishListError());
    }
  }
}

class PastaListBloc extends Bloc<FoodEvent, PastaState>{
  final GetFoodListUseCase _getFoodListUseCase;
  PastaListBloc(this._getFoodListUseCase): super(const PastaListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _pastaHandler(emit, event.category!);
    });
  }

  Future<void> _pastaHandler(Emitter<PastaState> emit, String params) async {
    emit(const PastaListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(PastaListDone(result));
    }else{
      emit(const PastaListError());
    }
  }
}

class PizzaBloc extends Bloc<FoodEvent, PizzaState>{
  final GetFoodListUseCase _getFoodListUseCase;
  PizzaBloc(this._getFoodListUseCase): super(const PizzaListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _pizzaHandler(emit, event.category!);
    });
  }

  Future<void> _pizzaHandler(Emitter<PizzaState> emit, String params) async {
    emit(const PizzaListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(PizzaListDone(result));
    }else{
      emit(const PizzaListError());
    }
  }
}

class ExtrasBloc extends Bloc<FoodEvent, ExtrasState>{
  final GetFoodListUseCase _getFoodListUseCase;
  ExtrasBloc(this._getFoodListUseCase): super(const ExtrasListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _extrasHandler(emit, event.category!);
    });
  }

  Future<void> _extrasHandler(Emitter<ExtrasState> emit, String params) async {
    emit(const ExtrasListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(ExtrasListDone(result));
    }else{
      emit(const ExtrasListError());
    }
  }
}

class DrinksBloc extends Bloc<FoodEvent, DrinksState>{
  final GetFoodListUseCase _getFoodListUseCase;
  DrinksBloc(this._getFoodListUseCase): super(const DrinksListLoading()) {
    on<FoodEvent>((event, emit) async {
      await _drinksHandler(emit, event.category!);
    });
  }

  Future<void> _drinksHandler(Emitter<DrinksState> emit, String params) async {
    emit(const DrinksListLoading());
    final result = await _getFoodListUseCase(params: params);
    if(result != null){
      emit(DrinksListDone(result));
    }else{
      emit(const DrinksListError());
    }
  }
}