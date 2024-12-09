import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/screens/details_screen/components/price_cartcounter_cartbutton.dart';
import 'package:my_app/screens/details_screen/components/titles.dart';
import 'package:my_app/screens/details_screen/details_screen.dart';

class BottomTitleReviewsCard extends StatelessWidget {
  const BottomTitleReviewsCard({
    Key? key,
    required this.size,
    required this.widget,
  }) : super(key: key);

  final Size size;
  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.54),
      // Thêm padding trên và hai bên
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: appBarColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color:shadowColor ,
          ),
        ],
      ),
      child: Column(
        children: [
          Titles(widget: widget),
          const SizedBox(height: DefaultPadding * 1.5),
          PriceCartAndCounter(widget: widget),
        ],
      ),
    );
  }
}
