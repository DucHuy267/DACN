import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/widgets/custom_image.dart';
import 'package:my_app/models/popular_model.dart';

class ProductItem extends StatelessWidget {
  final Popular product;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapFavorite;

  const ProductItem({super.key, required this.product, this.onTap, this.onTapFavorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        height: 300,
        child: Stack(
          children: [
            CustomImage(
              product.imageUrl,
              radius: 20,
              width: 200,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image); // Hoặc một hình ảnh thay thế nếu không tải được
              },
            ),
            Positioned(
              top: 260,
              left: 0,
              child: Text(
                '${product.price} đ',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: darker,
                ),
              ),
            ),
            Positioned(
              top: 280,
              left: 0,
              child: Text(
                product.name,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
