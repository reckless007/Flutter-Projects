import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String token,String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://productmanagement-2b786.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
     final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if(response.statusCode >= 400){
        isFavorite = oldStatus;
      notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
