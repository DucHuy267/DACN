import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/popular_model.dart';
import '../models/category_model.dart';

class ApiService {
  static const String baseUrl = 'http://172.20.10.12:4000';

  // Phương thức lấy tất cả danh mục
  static Future<List<Category>> fetchAllCategories() async {
    try {
      final url = Uri.parse('$baseUrl/categories/getAll');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Lỗi khi lấy danh sách danh mục');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  // Danh sách chung để lưu trữ sản phẩm
  static List<Popular> popularList = [];

  // Phương thức lấy danh sách tất cả sản phẩm
  static Future<List<Popular>> getAllProducts() async {
    if (popularList.isNotEmpty) {
      // Trả về danh sách sản phẩm nếu đã có dữ liệu
      return popularList;
    }
    final url = Uri.parse('$baseUrl/products/getAll');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      popularList = data.map((product) => Popular.fromJson(product)).toList();
      return popularList;
    } else {
      print('Lỗi khi lấy danh sách sản phẩm: ${response.body}');
      return [];
    }
  }

  // Phương thức lấy sản phẩm theo categoryId
  static Future<List<Popular>> getProductsByCategoryId(String categoryId) async {
    try {
      final url = Uri.parse('$baseUrl/products/category/$categoryId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        popularList = data.map((product) => Popular.fromJson(product)).toList();
        return popularList;
      } else {
        throw Exception('Lỗi khi lấy sản phẩm cho danh mục này');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  // Phương thức lấy thông tin sản phẩm theo productId
  static Future<Popular> getDetail(String productId) async {
    try {
      final url = Uri.parse('$baseUrl/products/getDetail/$productId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Popular.fromJson(data); // Trả về một đối tượng Popular
      } else {
        throw Exception('Lỗi khi lấy sản phẩm cho danh mục này');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  // Tìm kiếm sản phẩm theo tên
  static Future<List<Popular>> searchProductsByName(String name) async {
    final url = Uri.parse('$baseUrl/products/search?name=$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      popularList = data.map((product) => Popular.fromJson(product)).toList();
      return popularList;
    } else {
      throw Exception('Lỗi khi tìm kiếm sản phẩm');
    }
  }



  // Register function
  Future<Map<String, dynamic>> register(String name, String email, String password, String phone, String address) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
      }),
    );
    return jsonDecode(response.body);
  }

  // Login function
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['token'] != null) {
          // Store the token for future use
          // Use SharedPreferences or another secure storage method
          return {'token': responseData['token'], 'user': responseData['user']};
        } else {
          return {'error': 'Token not found in response'};
        }
      } else {
        return {'error': 'Invalid email or password'};
      }
    } catch (e) {
      return {'error': 'An error occurred during login'};
    }
  }




}

