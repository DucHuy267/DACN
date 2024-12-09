import 'package:flutter/material.dart';
import 'package:my_app/screens/cart_screen/cart_details.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/screens/details_screen/components/cart_counter.dart';
import 'package:my_app/models/popular_model.dart';

import '../details_screen.dart'; // Giả sử mô hình Popular đã được nhập

class PriceCartAndCounter extends StatelessWidget {
  const PriceCartAndCounter({
    super.key,
    required this.widget,
  });

  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            // Hiển thị giá tiền
            Text(
              '${widget.detail.price} đ',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 40), // Khoảng cách giữa giá và CartCounter
            const CartCounter(), // Số lượng sản phẩm
          ],
        ),
        const SizedBox(height: 12), // Khoảng cách giữa hàng và nút thêm vào giỏ hàng
        Container(
          // Nút thêm vào giỏ hàng
          width: double.infinity, // Đặt chiều rộng là tối đa
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: textColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: shadowColor,
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              _addToCart(context, widget.detail); // Gọi phương thức để thêm vào giỏ hàng
            },
            child: const Text(
              'Add To Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addToCart(BuildContext context, Popular product) {
    // Logic để thêm sản phẩm vào giỏ hàng
    // Ví dụ, bạn có thể có một lớp Cart để quản lý các mục trong giỏ hàng
    // Cart.add(product); // Đây là một chỗ giữ chỗ cho logic giỏ hàng thực tế

    // Hiển thị một Snackbar để xác nhận việc thêm
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} đã được thêm vào giỏ hàng!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
