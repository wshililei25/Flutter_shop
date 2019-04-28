import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../entity/cart.dart';
import '../../provide/cart_provide.dart';
import '../cart/cart_count.dart';

class CartItem extends StatelessWidget {
  CartEntity item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _checkBox(context, item),
          _image(item),
          _name(item),
          _price(context, item)
        ],
      ),
    );
  }

  Widget _checkBox(context, item) {
    return Container(
      child: Checkbox(
          value: item.isCheck,
          activeColor: Colors.pink[100],
          onChanged: (bool val) {
            item.isCheck = val;
            Provide.value<CartProvide>(context).checkState(item);
          }),
    );
  }

  Widget _image(item) {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(200),
      padding: EdgeInsets.all(5),
      /* decoration: BoxDecoration(
          border: Border.all(width: 1,color:Colors.black12)
      ),*/
      child: Image.network(item.image),
    );
  }

  Widget _name(item) {
    return Container(
        width: ScreenUtil().setWidth(300),
        padding: EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            Text(item.goodsName),
            Container(
              alignment: Alignment.centerLeft,
              child: CartCount(item),
            )
          ],
        ));
  }

  Widget _price(context, item) {
    return Container(
      width: ScreenUtil().setWidth(100),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price.toString()}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context).deleteCart(item.goodsId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
