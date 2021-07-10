import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_product/providers/cart.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_items.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeNmae = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    new OrderNow(cart: cart)
                  ],
                ),
              )),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItems(
              cart.items.values.toList()[i].title,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
            ),
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}

class OrderNow extends StatefulWidget {
  const OrderNow({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = true;
              });
              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
