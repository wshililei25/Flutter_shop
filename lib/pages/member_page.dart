import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('会员中心', style: TextStyle(color: Colors.white))),
      body: ListView(
        children: <Widget>[_topHeard(), _order(), _orderType(),_actionList()],
      ),
    );
  }

  Widget _topHeard() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pink,
      child: Column(
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 30),
              child: ClipOval(
                  child: Image.network(
                      'http://timecats-yunpan.oss-cn-hangzhou.aliyuncs.com/OSS%20LTAI1WzOdcWDGWNl%3AhnLSt/GTTIOA9i2eU0OeSPOpxfs%3D'))),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                '李沁',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(36)),
              ))
        ],
      ),
    );
  }

  Widget _order() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 2),
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.list),
          title: Text('我的订单'),
          trailing: Icon(Icons.chevron_right),
        ));
  }

  Widget _orderType() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(160),
      padding: EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[Icon(Icons.party_mode, size: 30), Text('待付款')],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder, size: 30),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car, size: 30),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste, size: 30),
                Text('待评价')
              ],
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 通用ListTile
   */
  Widget _myListTile(title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
          leading: Icon(Icons.add_alarm),
          title: Text(title),
          trailing: Icon(Icons.chevron_right)),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
        child: Column(
      children: <Widget>[
        _myListTile('领取优惠券'),
        _myListTile('已领取优惠券'),
        _myListTile('地址管理'),
        _myListTile('客服电话'),
      ],
    ));
  }
}
