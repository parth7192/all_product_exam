import 'dart:math';
import 'package:all_product_exam/Db_Helper/helper.dart';
import 'package:all_product_exam/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  void _addProduct() async {
    String name = _nameController.text;
    if (name.isNotEmpty) {
      await _productsCollection.add({'name': name});
      _nameController.clear();
      Navigator.pop(context);
    }
  }

  void _addProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Product',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          content: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Product Name',
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  hintText: 'Price',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: _addProduct,
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 22),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addToCart(String name) async {
    await CartDatabase.instance.insertProduct(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.instance.cart);
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _productsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              // itemCount: snapshot.data!.docs.length,
              children: snapshot.data!.docs.map((doc) {
                String name = doc['name'];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      tileColor: Colors.primaries[Random().nextInt(17)],
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _addToCart(name);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.instance.cart,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProductDialog,
        backgroundColor: Colors.brown,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
