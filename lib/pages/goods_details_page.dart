import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import './goods_details/goods_details_bottom.dart';
import './goods_details/goods_details_explain.dart';
import './goods_details/goods_details_tabbar.dart';
import './goods_details/goods_details_top.dart';
import './goods_details/goods_details_web.dart';
import '../provide/goods_details_provide.dart';

class GoodsDetailsPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context); //finish
                  }),
              title: Text(
                '商品详情',
                style: TextStyle(color: Colors.white),
              )),
          preferredSize: Size.fromHeight(55)),
      //FutureBuilder 异步加载
      body: FutureBuilder(
          future: _getGoodsDetails(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //Stack层叠控件
              return Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: ListView(
                      children: <Widget>[
                        GoodsDetailsTop(),
                        GoodsDetailsExplain(),
                        GoodsDetailsTabBar(),
                        GoodsDetailsWeb()
                      ],
                    ),
                  ),
                  Positioned(bottom: 0, left: 0, child: GoodsDetailsBottom())
                ],
              );
            } else {
              return Text('加载中');
            }
          }),
    );
  }

  Future _getGoodsDetails(BuildContext context) async {
    await Provide.value<GoodsDetailProvide>(context).getGoodsDetais(goodsId);
    return '完成加载';
  }
}
