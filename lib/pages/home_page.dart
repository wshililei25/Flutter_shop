import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../config/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/**
 * AutomaticKeepAliveClientMixin 保持页面状态
 */
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _globalKey = GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true; //保持页面状态

  @override
  void initState() {
    super.initState();
//    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    print('设备像素密度：${ScreenUtil.pixelRatio})');
    print('设备高度：${ScreenUtil.screenHeight})');
    print('设备宽度：${ScreenUtil.screenWidth})');
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('百姓生活+',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        preferredSize: Size.fromHeight(55),
      ),
      body: FutureBuilder(
          future: request('homePageContent', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> bannerList = (data['data']['slides'] as List).cast();
              List<Map> navList = (data['data']['category'] as List).cast();
              String adUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leadUrl = data['data']['shopInfo']['leaderImage'];
              String leadPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1List = (data['data']['floor1'] as List).cast();
              List<Map> floor2List = (data['data']['floor2'] as List).cast();
              List<Map> floor3List = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                    key: _globalKey,
                    bgColor: Colors.white,
                    textColor: Colors.pink[100],
                    moreInfoColor: Colors.pink[100],
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadReadyText: '上拉加载'),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: bannerList),
                    TopNavigator(navigatorList: navList),
                    AdBanner(adUrl: adUrl),
                    LeaderPhone(leaderUrl: leadUrl, leaderPhone: leadPhone),
                    Recommend(recommendList: recommendList),
                    FloorTitle(pictureAddress: floor1Title),
                    FloorShop(floorList: floor1List),
                    FloorTitle(pictureAddress: floor2Title),
                    FloorShop(floorList: floor2List),
                    FloorTitle(pictureAddress: floor3Title),
                    FloorShop(floorList: floor3List),
                    _hotGoods()
                  ],
                ),
                loadMore: () async {
                  print('开始加载更多');
                  var formData = {'page': page};
                  await request('homePageBelowConten', formData: formData)
                      .then((val) {
                    var data = json.decode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中...'),
              );
            }
          }),
    );
  }

  /**
   * 获取热卖商品
   */
/*  void _getHotGoods() {
    var formData = {'page': page};
    request('homePageBelowConten', formData: formData).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }*/

  Widget _hotTitle() {
    return Container(
//        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        color: Colors.transparent,
        padding: EdgeInsets.all(10),
        child: Text('火爆专区'));
  }

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(370),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(370)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('¥${val['mallPrice']}'),
                    Text('¥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough))
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      //流式布局
      return Wrap(
          spacing: 2, //一行两列
          children: listWidget);
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[_hotTitle(), _wrapList()],
      ),
    );
  }
}

/**
 * 首页轮播组件
 */
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setHeight(750),
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        //自动播放
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({this.navigatorList});

  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      //删除多余的
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setWidth(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), //禁止滚动  解决与上拉加载冲突问题
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adUrl;

  AdBanner({this.adUrl});

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(adUrl));
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderUrl;
  final String leaderPhone;

  LeaderPhone({this.leaderUrl, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(onTap: _launcherUrl, child: Image.network(leaderUrl)));
  }

  _launcherUrl() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能访问';
    }
  }
}

class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 8, 0, 8),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text('商品推荐', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text('¥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey))
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}

/**
 * 楼层标题
 */
class FloorTitle extends StatelessWidget {
  final String pictureAddress;

  FloorTitle({this.pictureAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(pictureAddress),
    );
  }
}

/**
 * 楼层商品列表
 */
class FloorShop extends StatelessWidget {
  final List floorList;

  FloorShop({this.floorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorList[1]),
            _goodsItem(floorList[2])
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[_goodsItem(floorList[3]), _goodsItem(floorList[4])],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods['image']),
      ),
    );
  }
}
