import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import '../../../widgets/custom_image.dart';
import '../../../models/category_model.dart';
import '../../product/product_screen.dart';

class CollectionBox extends StatelessWidget {
  final Category category;
  final bool isCardBox;
  const CollectionBox({super.key, required this.category, this.isCardBox = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Chuyển hướng đến trang ProductScreen với danh mục đã chọn
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(category: category),
          ),
        );
      },
      child: isCardBox
          ? Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // Thay đổi vị trí bóng
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primary,
                ),
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                category.image, // Sử dụng hình ảnh từ mô hình Category
                width: 70,
                height: 70,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image); // Hoặc một hình ảnh thay thế nếu không tải được
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category.categoryName, // Sử dụng categoryName từ mô hình Category
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      )
          : Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primary,
                ),
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                category.image, // Sử dụng hình ảnh từ mô hình Category
                width: 65,
                height: 65,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image); // Hoặc một hình ảnh thay thế nếu không tải được
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category.categoryName, // Sử dụng categoryName từ mô hình Category
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
