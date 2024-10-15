import 'dart:math';

import 'package:all_product_exam/Db_Helper/helper.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> _cartItems = [];

  void _refreshCart() async {
    final data = await CartDatabase.instance.getProducts();
    setState(() {
      _cartItems = data;
    });
  }

  void _removeFromCart(int id) async {
    await CartDatabase.instance.deleteProduct(id);
    _refreshCart();
  }

  @override
  void initState() {
    super.initState();
    _refreshCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _cartItems.length,
          itemBuilder: (context, index) {
            final item = _cartItems[index];
            return Column(
              children: [
                ListTile(
                  title: Text(
                    item['name'],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  tileColor: Colors.primaries[Random().nextInt(17)],
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () => _removeFromCart(item['id']),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
