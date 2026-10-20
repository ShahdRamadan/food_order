import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/order_controller.dart';
import '../../models/order_item_model.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem orderItem;

  const OrderItemTile({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OrderController>();

    return ListTile(
      leading: Text(orderItem.food.icon, style: const TextStyle(fontSize: 28)),
      title: Text(
        orderItem.food.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Unit Price: \$${orderItem.food.price.toStringAsFixed(2)}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () => controller.decrementItem(orderItem.food),
          ),
          Text(
            '${orderItem.quantity}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
            onPressed: () => controller.addToOrder(orderItem.food),
          ),
          const SizedBox(width: 8),
          Text(
            '\$${orderItem.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () => controller.removeOrderItem(orderItem.food.id),
          ),
        ],
      ),
    );
  }
}
