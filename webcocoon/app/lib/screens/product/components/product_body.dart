import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/screens/product/components/product_item.dart';
import 'package:my_app/models/popular_model.dart';
import 'package:my_app/services/api_service.dart';
import '../../details_screen/details_screen.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({
    super.key,
    required this.size,
    required this.categoryId, this.products,
  });

  final Size size;
  final List<Popular>? products;
  final String categoryId; // Trường để lưu ID của danh mục\


  @override
  _ProductBodyState createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  List<Popular> products = []; // Danh sách sản phẩm

  @override
  void initState() {
    super.initState();
    fetchProducts(widget.categoryId); // Lấy danh sách sản phẩm dựa trên categoryId
  }

  Future<void> fetchProducts(String categoryId) async {
    List<Popular> fetchedProducts = await ApiService.getProductsByCategoryId(categoryId);
    setState(() {
      products = fetchedProducts.cast<Popular>(); // Cập nhật danh sách sản phẩm
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // Lưới sản phẩm
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Điều chỉnh khoảng cách padding nếu cần
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                return ProductItem(
                  product: products[index],
                  onTap: () {
                    // Chuyển hướng đến trang DetailsScreen khi nhấn vào sản phẩm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(detail: products[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
