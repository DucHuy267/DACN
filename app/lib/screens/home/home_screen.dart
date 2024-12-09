import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/theme/color.dart';
import 'package:my_app/utils/data.dart';
import 'package:my_app/screens/home/components/collection_box.dart';
import 'package:my_app/screens/home/components/popular_item.dart';
import 'package:my_app/screens/home/components/search.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/models/popular_model.dart';
import 'package:my_app/models/category_model.dart';

import '../product/product_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Popular> _popularProducts = [];
  List<Category> _categories = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await Future.wait([_fetchPopularProducts(), _fetchCategories()]);
    } catch (error) {
      print('Lỗi khi lấy dữ liệu: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchPopularProducts() async {
    try {
      _popularProducts = await ApiService.getAllProducts();
    } catch (e) {
      print('Lỗi khi lấy sản phẩm phổ biến: $e');
    }
  }

  Future<void> _fetchCategories() async {
    try {
      _categories = await ApiService.fetchAllCategories();
    } catch (e) {
      print('Lỗi khi lấy danh mục: $e');
    }
  }

  Future<void> _searchProducts(String name) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final searchResults = await ApiService.searchProductsByName(name);
      setState(() {
        _popularProducts = searchResults;
      });
    } catch (e) {
      setState(() => _hasError = true);
      print('Lỗi khi tìm kiếm sản phẩm: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: getAppBar(),
          ),
          SliverToBoxAdapter(
            child: Search(
              size: size,
              onSearch: _searchProducts, // Call the search function when the user submits a query
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => buildBody(),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, color: labelColor, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    profile["name"]!,
                    style: const TextStyle(color: labelColor, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                "Chào buổi sáng!",
                style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                "Loại sản phẩm",
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            getCollections(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
              child: Text(
                "Phổ biến",
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            _isLoading ? const Center(child: CircularProgressIndicator()) : getPopulars(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget getCollections() {
    return _isLoading || _categories.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CollectionBox(category: category), // Truyền đối tượng Category vào CollectionBox
          );
        }).toList(),
      ),
    );
  }

  Widget getPopulars() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 370,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: _popularProducts.map((popular) {
        return PopularItem(
          popular: popular,
        );
      }).toList(),
    );
  }
}
