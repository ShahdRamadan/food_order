import 'package:flutter/material.dart';
import '../models/food_item_model.dart';
import '../models/order_item_model.dart';

class OrderController extends ChangeNotifier {
  final List<FoodItem> _menuItems = [
    FoodItem(
      id: '1',
      name: 'Classic Grilled Burger',
      description: 'Beef patty with cheddar cheese and special sauce',
      price: 12.50,
      icon: '🍔',
    ),
    FoodItem(
      id: '2',
      name: 'Margherita Pizza',
      description: 'Italian dough with tomato sauce and mozzarella',
      price: 15.00,
      icon: '🍕',
    ),
    FoodItem(
      id: '3',
      name: 'Chicken Alfredo Pasta',
      description: 'Fettuccine pasta with creamy mushroom sauce and chicken',
      price: 14.00,
      icon: '🍝',
    ),
    FoodItem(
      id: '4',
      name: 'Crispy French Fries',
      description: 'Golden crispy fries served with cheddar dip',
      price: 5.50,
      icon: '🍟',
    ),
    FoodItem(
      id: '5',
      name: 'Fresh Orange Juice',
      description: '100% natural squeezed orange juice',
      price: 4.50,
      icon: '🍹',
    ),
  ];

  final List<OrderItem> _orderItems = [];
  String _orderType = 'Takeaway';
  final double _taxRate = 0.14;

  List<FoodItem> get menuItems => List.unmodifiable(_menuItems);
  List<OrderItem> get orderItems => List.unmodifiable(_orderItems);
  String get orderType => _orderType;

  void setOrderType(String type) {
    _orderType = type;
    notifyListeners();
  }

  int getItemQuantity(String foodId) {
    final index = _orderItems.indexWhere((item) => item.food.id == foodId);
    return index != -1 ? _orderItems[index].quantity : 0;
  }

  void addToOrder(FoodItem food) {
    final index = _orderItems.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      _orderItems[index].quantity++;
    } else {
      _orderItems.add(OrderItem(food: food));
    }
    notifyListeners();
  }

  void decrementItem(FoodItem food) {
    final index = _orderItems.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      if (_orderItems[index].quantity > 1) {
        _orderItems[index].quantity--;
      } else {
        _orderItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeOrderItem(String foodId) {
    _orderItems.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  int get totalItemsCount {
    return _orderItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double get subtotal {
    return _orderItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get taxAmount => subtotal * _taxRate;

  double get finalTotal => subtotal + taxAmount;

  void submitOrder() {
    _orderItems.clear();
    notifyListeners();
  }
}
