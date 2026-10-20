import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/order_controller.dart';
import '../widgets/bill_summary_section.dart';
import '../widgets/order_item_tile.dart';

class OrderSummaryView extends StatelessWidget {
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: controller.orderItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your order is currently empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text('Order Type:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'Takeaway',
                              label: Text('Takeaway'),
                              icon: Icon(Icons.takeout_dining),
                            ),
                            ButtonSegment(
                              value: 'Dine-in',
                              label: Text('Dine-in'),
                              icon: Icon(Icons.restaurant),
                            ),
                          ],
                          selected: {controller.orderType},
                          onSelectionChanged: (newSelection) {
                            context
                                .read<OrderController>()
                                .setOrderType(newSelection.first);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.orderItems.length,
                    itemBuilder: (context, index) {
                      final orderItem = controller.orderItems[index];
                      return OrderItemTile(orderItem: orderItem);
                    },
                  ),
                ),
                const BillSummarySection(),
              ],
            ),
    );
  }
}
