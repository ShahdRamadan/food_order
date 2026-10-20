import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/order_controller.dart';
import '../../models/food_item_model.dart';

class MenuItemCard extends StatelessWidget {
  final FoodItem food;

  const MenuItemCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderController>();
    final quantity = controller.getItemQuantity(food.id);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(food.icon, style: const TextStyle(fontSize: 34)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${food.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            quantity == 0
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () =>
                        context.read<OrderController>().addToOrder(food),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove,
                              color: Colors.deepOrange, size: 20),
                          onPressed: () => context
                              .read<OrderController>()
                              .decrementItem(food),
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add,
                              color: Colors.deepOrange, size: 20),
                          onPressed: () =>
                              context.read<OrderController>().addToOrder(food),
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
