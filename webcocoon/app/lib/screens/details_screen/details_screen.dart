import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/screens/details_screen/components/bottom_details_card.dart';
import 'package:my_app/models/popular_model.dart';

class DetailsScreen extends StatefulWidget {
  final Popular detail;
  const DetailsScreen({super.key, required this.detail});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int numberOfItems = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildDetailsScreenAppbar(context),
      body: Column(
        children: [
          SizedBox(
            height: size.height - 80,
            child: Stack(
              children: [
                topImageAndDetails(size),
                BottomTitleReviewsCard(size: size, widget: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column topImageAndDetails(Size size) {
    return Column(
      children: [
        Image.network(
          widget.detail.imageUrl,
          height: size.height * 0.5,
          width: size.width,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image); // Hiển thị biểu tượng thay thế nếu hình ảnh không tải được
          },
        ),
      ],
    );
  }

  AppBar buildDetailsScreenAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: BackgroundColor,
      leading: IconButton(
        onPressed: (() {
          Navigator.pop(context);
        }),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: textColor,
        ),
      ),
    );
  }
}
