import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import './provide/counter.dart';
import './provide/childCategory.dart';
import './provide/category_gods_list_provide.dart';
import './router/appliction.dart';
import './router/routers.dart';

void main() {
  var counter = Counter();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var childCategoryProvide = ChildCategoryProvide();
  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var router = Router();
    Routes.configRoute(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '百姓生活+',
        theme: ThemeData(primaryColor: Colors.pink[200]),
        home: IndexPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
