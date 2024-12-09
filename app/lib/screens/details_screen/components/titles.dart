import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/screens/details_screen/details_screen.dart';

class Titles extends StatelessWidget {
  const Titles({
    super.key,
    required this.widget,
  });

  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tên sản phẩm
        Text(
          widget.detail.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 6), // Khoảng cách giữa tên và mô tả
        const Text('Description',
          style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: labelColor,
          ),
        ),
        // Chi tiết sản phẩm có thể cuộn
        Container(
          constraints: const BoxConstraints(maxHeight: 65), // Giới hạn chiều cao tối đa để cuộn
          child: SingleChildScrollView(
            child: Text(
              widget.detail.description, // chi tiết sp
              style: const TextStyle(
                fontSize: 16, // Kích thước chữ cho mô tả
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
