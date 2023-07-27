


class Food{
  int id;
  String name;
  String description;
  double price;
  String ingredients;
  String image;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.ingredients,
    required this.image,
  });


  factory Food.fromJson(Map<String, dynamic> jsonData) {
    return Food(
      id: int.parse(jsonData['food_id']),
      name: jsonData['name'] as String,
      price: double.parse(jsonData['price']),
      ingredients: jsonData['ingredients'] as String,
      description: jsonData['description'] as String,
      image: '',
    );
  }

}