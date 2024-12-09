import 'package:flutter/material.dart';
import 'package:my_app/models/popular_model.dart';
import 'package:my_app/screens/cart_screen/components/cart_item_list.dart';
import 'package:my_app/screens/cart_screen/components/bottom_Price_Row.dart';


class CartDetails extends StatefulWidget {
  final Popular detail; // Sản phẩm được truyền vào từ chi tiết sản phẩm
  const CartDetails({super.key, required this.detail});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  List<Popular> cartItems = []; // Danh sách sản phẩm trong giỏ hàng
  int totalItems = 0; // Tổng số lượng sản phẩm
  double subtotal = 0.0; // Tổng tiền của giỏ hàng

  @override
  void initState() {
    super.initState();
    addToCart(widget.detail); // Thêm sản phẩm ban đầu
  }

  void addToCart(Popular item) {
    setState(() {
      cartItems.add(item);
      totalItems++;
      subtotal += item.price;
    });
  }

  void removeFromCart(Popular item) {
    setState(() {
      cartItems.remove(item);
      totalItems--;
      subtotal -= item.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Component hiển thị danh sách sản phẩm trong giỏ hàng
          CartItemList(
            cartItems: cartItems,
            onRemoveItem: removeFromCart,
            totalItems: totalItems,
          ),
          const SizedBox(height: 20),
          // Component hiển thị tổng tiền
          BottomPriceRow(title: 'Tổng tiền hàng', price: subtotal),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Chi tiết giỏ hàng"),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
