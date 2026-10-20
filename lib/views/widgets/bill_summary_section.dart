import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/order_controller.dart';

class BillSummarySection extends StatelessWidget {
  const BillSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal:', controller.subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow('Tax (14%):', controller.taxAmount),
          const Divider(height: 24, thickness: 1),
          _buildSummaryRow(
            'Total:',
            controller.finalTotal,
            isTotal: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _confirmOrderDialog(context, controller),
              child: const Text(
                'Confirm & Send Order',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.deepOrange : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _confirmOrderDialog(BuildContext context, OrderController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Order Confirmed'),
          ],
        ),
        content: Text(
          'Order Type: ${controller.orderType}\nTotal Paid: \$${controller.finalTotal.toStringAsFixed(2)}\n\nYour order has been sent to the kitchen!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.submitOrder();
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
