import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';

class CreateBottomPriceRow extends StatelessWidget {
  final String title;
  final double price;
  final bool showTotalItemText;
  const CreateBottomPriceRow({
    super.key,
    required this.title,
    required this.price,
    required this.showTotalItemText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: DefaultPadding / 2),
                child: Text(
                  showTotalItemText ? '(4 Items)' : '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                '$price 00 VND',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    right: DefaultPadding, left: DefaultPadding / 3),
                child: Text(
                  'VND',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: TextLightColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
