import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

import '../config/service_method.dart';
import '../entity/category.dart';
import '../entity/categoryGoods.dart';
import '../provide/category_gods_list_provide.dart';
import '../provide/childCategory.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('商品分类',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          preferredSize: Size.fromHeight(55)),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftNavState(),
            Column(
              children: <Widget>[RigghtNav(), CagegoryGoods()],
            )
          ],
        ),
      ),
    );
  }
}

/**
 * 左侧大类导航
 */
class LeftNavState extends StatefulWidget {
  @override
  _LeftNavStateState createState() => _LeftNavStateState();
}

class _LeftNavStateState extends State<LeftNavState> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategroy();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategoryProvide>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        width: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26.0)),
        ),
      ),
    );
  }

  void _getCategroy() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());

      CategoryEntity categoryEntity = CategoryEntity.fromJson(data);
//      list.data.forEach((item) => print('返回---${item.mallCategoryName}'));
      setState(() {
        list = categoryEntity.data;
      });
      Provide.value<ChildCategoryProvide>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var formData = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': "",
      'page': 1
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      GoodsListEntity goodsListEntity = GoodsListEntity.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsListEntity.data);
    });
  }
}

/**
 * 右侧子分类
 */
class RigghtNav extends StatefulWidget {
  @override
  _RigghtNavState createState() => _RigghtNavState();
}

class _RigghtNavState extends State<RigghtNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
        builder: (context, child, childCategoryProvide) {
      return Container(
        height: ScreenUtil().setHeight(90),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: childCategoryProvide.childCategoryList.length,
          itemBuilder: (context, index) {
            return _rightInkWell(
                childCategoryProvide.childCategoryList[index], index);
          },
        ),
      );
    });
  }

  Widget _rightInkWell(CategorySecondEntity item, int index) {
    bool isClick;
    isClick = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provide.value<ChildCategoryProvide>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink[100] : Colors.black),
        ),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      ),
    );
  }

  void _getGoodsList(String categoryChildId) async {
    var formData = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId': categoryChildId,
      'page': 1
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      GoodsListEntity goodsListEntity = GoodsListEntity.fromJson(data);
      if (null == goodsListEntity.data || goodsListEntity.data.length <= 0) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodsListEntity.data);
      }
    });
  }
}

/**
 * 商品列表
 */
class CagegoryGoods extends StatefulWidget {
  @override
  _CagegoryGoodsState createState() => _CagegoryGoodsState();
}

class _CagegoryGoodsState extends State<CagegoryGoods> {
  var scrollController = ScrollController();
  GlobalKey<RefreshFooterState> _globalKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategoryProvide>(context).page == 1) {
            //ListView置顶
            scrollController.jumpTo(0);
          }
        } catch (e) {
          print('第一次进入页面');
        }

        if (null == data || data.list.length <= 0) {
          return Center(
              child: Text('暂无数据',
                  style: TextStyle(fontSize: ScreenUtil().setSp(26))));
        } else {
          //可伸缩组建，解决高度溢出
          return Expanded(
            child: Container(
                width: ScreenUtil().setWidth(570),
                child: EasyRefresh(
                  refreshFooter: ClassicsFooter(
                      key: _globalKey,
                      bgColor: Colors.white,
                      textColor: Colors.pink[100],
                      moreInfoColor: Colors.pink[100],
                      showMore: true,
                      noMoreText: Provide.value<ChildCategoryProvide>(context)
                          .noMoreText,
                      moreInfo: '加载中',
                      loadReadyText: '上拉加载'),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: data.list.length,
                    itemBuilder: (context, index) {
                      return _listItem(data.list, index);
                    },
                  ),
                  loadMore: () async {
                    print('上啦中');
                    _getMoreGoodsList();
                  },
                )),
          );
        }
      },
    );
  }

  Widget _listItem(List newList, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _goodsImage(List newList, index) {
    return Container(
        width: ScreenUtil().setWidth(200),
        child: Image.network(newList[index].image));
  }

  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text('价格：¥${newList[index].presentPrice}',
              style: TextStyle(
                  color: Colors.pink[100], fontSize: ScreenUtil().setSp(30))),
          Text('¥${newList[index].oriPrice}',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough))
        ],
      ),
    );
  }

  void _getMoreGoodsList() async {
    Provide.value<ChildCategoryProvide>(context).addPage();
    var formData = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId':
          Provide.value<ChildCategoryProvide>(context).categoryChildId,
      'page': Provide.value<ChildCategoryProvide>(context).page,
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      GoodsListEntity goodsListEntity = GoodsListEntity.fromJson(data);
      if (null == goodsListEntity.data || goodsListEntity.data.length <= 0) {
        Fluttertoast.showToast(
            msg: '没有更多了',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.pink[100],
            fontSize: 16);
        Provide.value<ChildCategoryProvide>(context).changeNoMoreText('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreGoodsList(goodsListEntity.data);
      }
    });
  }
}
