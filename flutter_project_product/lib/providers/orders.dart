import 'package:flutter/material.dart';
//import '../widgets/order_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/cart.dart';

class Orderitem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Orderitem({this.id, this.amount, this.dateTime, this.products});
}

class Orders with ChangeNotifier {
  List<Orderitem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken,this._orders,this.userId);

  List<Orderitem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://productmanagement-2b786.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<Orderitem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        Orderitem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://productmanagement-2b786.firebaseio.com/orders/$userId.json';
    final time = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': time.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
        0,
        Orderitem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: time,
          products: cartProducts,
        ));
    notifyListeners();
  }
}
