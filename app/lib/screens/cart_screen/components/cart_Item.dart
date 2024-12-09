import 'package:flutter/material.dart';
import 'package:my_app/models/popular_model.dart';

class CartItem extends StatelessWidget {
  final Popular product;
  final VoidCallback onRemoveItem;

  const CartItem({
    Key? key,
    required this.product,
    required this.onRemoveItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          product.imageUrl, // Hình ảnh sản phẩm
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name, // Tên sản phẩm
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 30),
                TextButton(
                  onPressed: onRemoveItem, // Gọi hàm xóa sản phẩm khỏi giỏ
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${product.price}', // Giá sản phẩm
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
