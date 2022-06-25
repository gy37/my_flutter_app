import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'start.dart';
import 'develop.dart';
import 'cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MultiProvider(
        providers: [
          Provider(create: (context) => CatalogModel()),
          ChangeNotifierProxyProvider<CatalogModel, CartModel>(
              create: (_) => CartModel(),
              update: (context, catalog, cart) {
                if (cart == null) throw ArgumentError.notNull('cart');
                cart.catalog = catalog;
                return cart;
              }),
        ],
        child: MaterialApp(
          title: 'Startup Name Generator',
          theme: ThemeData(
            // primaryColor: Colors.white, //primaryColor没有效果
            primarySwatch: Colors.red,
          ),
          home: const HomePage(),
          routes: {
            //开始使用Flutter
            '/words': (BuildContext context) => const RandomWords(),
            '/update': (BuildContext context) => const UpdateWidgetPage(),
            '/animate': (BuildContext context) =>
                const AnimationPage(title: 'Fade Demo'),
            '/paint': (BuildContext context) => const PaintPage(),
            '/network': (BuildContext context) => const NetWorkPage(),
            '/isolate': (BuildContext context) => const IsolatePage(),
            '/asset': (BuildContext context) => const AssetPage(),
            '/gesture': (BuildContext context) => const GesturePage(),
            '/textField': (BuildContext context) => const TextFieldPage(),
            //开发文档
            '/myScaffold': (BuildContext context) => const MyScaffold(),
            '/cuperino': (BuildContext context) => const CuperinoPage(),
            '/shoppingCart': (BuildContext context) => const ShoppingList(
                    products: [
                      Product(name: 'Eggs'),
                      Product(name: 'Flour'),
                      Product(name: 'Chocolate chips')
                    ]),
            '/layout': (BuildContext context) => const LayoutPage(),
            '/list': (BuildContext context) => const ListViewPage(),
            '/layoutTutorial': (BuildContext context) => const LayoutTutorial(),
            '/constraints': (BuildContext context) => const ConstraintsPage(),
            '/provider': (BuildContext context) => const ProviderExample(),
            '/cart': (BuildContext context) => const MyCart(),
            '/catalog': (BuildContext context) => const MyCatalog(),
          },
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('en', 'US'),
          // ],
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: getButtons(context),
    );
  }

  Widget getButtons(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 20.0,
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转列表页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/words');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转状态修改页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/update');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转动画页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/animate');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转绘制页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/paint');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转网络页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/network');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转Isolate页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/isolate');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转资源页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/asset');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转手势页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/gesture');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转输入框页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/textField');
              },
            ),
            const Divider(),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转自定义组件页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/myScaffold');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转iOS组件页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/cuperino');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转购物车'),
              onPressed: () {
                Navigator.of(context).pushNamed('/shoppingCart');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转布局页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/layout');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转列表页'),
              onPressed: () {
                Navigator.of(context).pushNamed('/list');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转布局教程'),
              onPressed: () {
                Navigator.of(context).pushNamed('/layoutTutorial');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转布局约束'),
              onPressed: () {
                Navigator.of(context).pushNamed('/constraints');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转Provider状态管理'),
              onPressed: () {
                Navigator.of(context).pushNamed('/provider');
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text('跳转Catalog'),
              onPressed: () {
                Navigator.of(context).pushNamed('/catalog');
              },
            ),
          ],
        ));
  }
}
