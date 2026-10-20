import 'food_item_model.dart';

class OrderItem {
  final FoodItem food;
  int quantity;

  OrderItem({
    required this.food,
    this.quantity = 1,
  });

  double get totalPrice => food.price * quantity;
}
