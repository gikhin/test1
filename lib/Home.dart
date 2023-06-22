import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/Profile.dart';

import 'package:test1/Moredetails.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is Map && responseData.containsKey("products")) {
        setState(() {
          data = responseData["products"];
        });
      } else {
        print("Invalid response format: $responseData");
      }
    } else {
      print("Error occurred: ${response.statusCode}");
    }
  }
  void navigateToDetailsScreen(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Stock(productId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1967AF),
        title: Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            icon: Icon(Icons.person_outlined),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final product = data[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(product["thumbnail"]),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(product["brand"])),

                  ],
                ),
                subtitle: Row(
                  children: [
                    Expanded(child: Text(product["description"])),

                  ],
                ),
                trailing: TextButton(
                  onPressed: () {
                    navigateToDetailsScreen(product["id"]);
                  },
                  child: Text('More',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF1967AF))),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
