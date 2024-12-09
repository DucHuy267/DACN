import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
    required this.size,
    required this.onSearch,
  }) : super(key: key);

  final Size size;
  final Function(String) onSearch;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              height: 53,
              width: widget.size.width - 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    widget.onSearch(value);
                  }
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: textColor),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                widget.onSearch(_searchController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

