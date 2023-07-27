abstract class GetRandomFoodState{
  final List<Map<String, dynamic>>? foodMap;
  const GetRandomFoodState({this.foodMap});
}

class GetRandomFoodInitial extends GetRandomFoodState{
  const GetRandomFoodInitial();
}

class GetRandomFoodLoading extends GetRandomFoodState{
  const GetRandomFoodLoading();
}

class GetRandomFoodError extends GetRandomFoodState{
  const GetRandomFoodError();
}

class GetRandomFoodDone extends GetRandomFoodState{
  const GetRandomFoodDone(List<Map<String, dynamic>> foodList) : super (foodMap: foodList);
}