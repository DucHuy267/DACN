import 'package:flutter/material.dart';
import 'package:my_app/models/popular_model.dart';
import 'package:my_app/screens/cart_screen/components/cart_Item.dart';

class CartItemList extends StatelessWidget {
  final List<Popular> cartItems;
  final Function(Popular) onRemoveItem;
  final int totalItems;

  const CartItemList({
    Key? key,
    required this.cartItems,
    required this.onRemoveItem,
    required this.totalItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cartItems.length,
        itemExtent: 120,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return CartItem(
            product: product,
            onRemoveItem: () => onRemoveItem(product), // Xóa sản phẩm
          );
        },
      ),
    );
  }
}
