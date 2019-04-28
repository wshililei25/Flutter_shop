import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../pages/cart/cart_bottom.dart';
import '../pages/cart/cart_item.dart';
import '../provide/cart_provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车', style: TextStyle(color: Colors.white)),
        ),
        body: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              List cartList = Provide.value<CartProvide>(context).cartList;
              if (snapshot.hasData && cartList != null) {
                return Stack(
                  children: <Widget>[
                    Provide<CartProvide>(
                      builder: (context, child, childItem) {
                        cartList = Provide.value<CartProvide>(context).cartList;
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              return CartItem(cartList[index]);
                            });
                      },
                    ),
                    Positioned(bottom: 0, left: 0,right: 0, child: CartBottom())
                  ],
                );
              } else {
                return Text('暂无数据');
              }
            }));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
