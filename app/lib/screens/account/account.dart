import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Map<String, dynamic> user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from API
  Future<void> _fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final response = await http.get(
          Uri.parse('http://192.168.0.109:4000/users/${prefs.getString('userId')}'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          setState(() {
            user = jsonDecode(response.body);
            isLoading = false;
          });
        } else {
          // Handle errors
          print('Failed to fetch user data');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user["avatarUrl"] ?? ''),
            ),
            SizedBox(height: 20),
            Text(user["name"] ?? "Name not available",
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text(user["email"] ?? "Email not available",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),
            ListTile(
              title: Text("My Orders"),
              onTap: () {
                // Navigate to orders page
              },
            ),
            ListTile(
              title: Text("Sign Out"),
              onTap: _showConfirmLogout,
            ),
          ],
        ),
      ),
    );
  }

  // Show logout confirmation dialog
  void _showConfirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: _logout,
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  // Handle user logout
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
    Navigator.of(context).pushReplacementNamed('/login');  // Navigate to login screen
  }
}
