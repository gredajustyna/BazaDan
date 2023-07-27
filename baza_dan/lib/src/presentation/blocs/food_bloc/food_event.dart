abstract class FoodEvent{
  final String? category;
  const FoodEvent({this.category});
}

class GetFastFood extends FoodEvent{
  const GetFastFood(String category) : super(category: category);
}

class GetSandwiches extends FoodEvent{
  const GetSandwiches(String category) : super(category: category);
}

class GetDishes extends FoodEvent{
  const GetDishes(String category) : super(category: category);
}

class GetPasta extends FoodEvent{
  const GetPasta(String category) : super(category: category);
}

class GetPizza extends FoodEvent{
  const GetPizza(String category) : super(category: category);
}

class GetExtras extends FoodEvent{
  const GetExtras(String category) : super(category: category);
}

class GetDrinks extends FoodEvent{
  const GetDrinks(String category) : super(category: category);
}