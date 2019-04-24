import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/goods_details_provide.dart';

class GoodsDetailsPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getGoodsDetails(context);
    return Container(
      child: Text(goodsId),
    );
  }

  void _getGoodsDetails(BuildContext context) async {
    await Provide.value<GoodsDetailProvide>(context).getGoodsDetais(goodsId);
  }
}
