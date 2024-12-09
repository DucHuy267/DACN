import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/custom_image.dart';
import '../../../models/popular_model.dart';
import '../../details_screen/details_screen.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({ super.key, required this.popular, this.radius = 20 });
  final Popular popular;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Chuyển hướng đến trang DetailsScreen khi nhấn vào sản phẩm
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(detail: popular),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: [
            Container(
              child: CustomImage(popular.imageUrl, // Sử dụng thuộc tính imageUrl từ Product
                radius: radius, width: double.infinity, height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image); // Hoặc một hình ảnh thay thế nếu không tải được
                },
              ),
            ),
            Container(
              width: double.infinity, height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.5),
                    Colors.white.withOpacity(.01),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12, left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    popular.name, // Sử dụng thuộc tính name từ Product
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/tag-dollar.svg", width: 17, height: 17, color: Colors.white,),
                      const SizedBox(width: 5,),
                      Text('${popular.price} đ', style: const TextStyle(fontSize: 15, color: Colors.white,)) // Sử dụng thuộc tính price từ Product
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
