import 'package:baza_dan/src/domain/entities/food.dart';

abstract class FastFoodState{
  final List<Food>? food;
  const FastFoodState({this.food});
}

class FastListLoading extends FastFoodState{
  const FastListLoading();
}

class FastListError extends FastFoodState{
  const FastListError();
}

class FastListDone extends FastFoodState{
  const FastListDone(List<Food> food) : super(food: food);
}

abstract class BurgerState{
  final List<Food>? food;
  const BurgerState({this.food});
}

class BurgerListLoading extends BurgerState{
  const BurgerListLoading();
}

class BurgerListError extends BurgerState{
  const BurgerListError();
}

class BurgerListDone extends BurgerState{
  const BurgerListDone(List<Food> food) : super(food: food);
}

abstract class DishState{
  final List<Food>? food;
  const DishState({this.food});
}

class DishListLoading extends DishState{
  const DishListLoading();
}

class DishListError extends DishState{
  const DishListError();
}

class DishListDone extends DishState{
  const DishListDone(List<Food> food) : super(food: food);
}

abstract class PastaState{
  final List<Food>? food;
  const PastaState({this.food});
}

class PastaListLoading extends PastaState{
  const PastaListLoading();
}

class PastaListError extends PastaState{
  const PastaListError();
}

class PastaListDone extends PastaState{
  const PastaListDone(List<Food> food) : super(food: food);
}

abstract class PizzaState{
  final List<Food>? food;
  const PizzaState({this.food});
}

class PizzaListLoading extends PizzaState{
  const PizzaListLoading();
}

class PizzaListError extends PizzaState{
  const PizzaListError();
}

class PizzaListDone extends PizzaState{
  const PizzaListDone(List<Food> food) : super(food: food);
}

abstract class ExtrasState{
  final List<Food>? food;
  const ExtrasState({this.food});
}

class ExtrasListLoading extends ExtrasState{
  const ExtrasListLoading();
}

class ExtrasListError extends ExtrasState{
  const ExtrasListError();
}

class ExtrasListDone extends ExtrasState{
  const ExtrasListDone(List<Food> food) : super(food: food);
}

abstract class DrinksState{
  final List<Food>? food;
  const DrinksState({this.food});
}

class DrinksListLoading extends DrinksState{
  const DrinksListLoading();
}

class DrinksListError extends DrinksState{
  const DrinksListError();
}

class DrinksListDone extends DrinksState{
  const DrinksListDone(List<Food> food) : super(food: food);
}