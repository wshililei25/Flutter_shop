import 'package:flutter/material.dart';

class GoodsDetailsPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(goodsId),
    );
  }
}
