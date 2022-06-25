import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, Key? key}) : super(key: key);
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: const EdgeInsets.only(top: 46.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
          ),
          Expanded(child: title),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          MyAppBar(
              title: Text(
            'Example title',
            style: Theme.of(context).primaryTextTheme.headline6,
          )),
          const Expanded(
              child: Center(
            child: Text('Hello, world!'),
          )),
          const MyButton(),
          const Counter(),
        ],
      ),
    ));
  }
}

class CuperinoPage extends StatelessWidget {
  const CuperinoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: Icon(CupertinoIcons.share),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.lightGreen[500]),
        child: const Center(child: Text('Engage')),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(onPressed: _increment, child: const Text('Increment')),
        const SizedBox(
          width: 16,
        ),
        Text('Count: $_counter'),
      ],
    );
  }
}

class Product {
  const Product({required this.name});
  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem(
      {required this.product,
      required this.inCart,
      required this.onCartChanged})
      : super(key: ObjectKey(product));
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key, required this.products}) : super(key: key);
  final List<Product> products;
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((product) {
          return ShoppingListItem(
              product: product,
              inCart: _shoppingCart.contains(product),
              onCartChanged: _handleCartChanged);
        }).toList(),
      ),
    );
  }
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({Key? key}) : super(key: key);

  Widget _buildStack() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('images/1@2x.png'),
          radius: 100,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black45),
          child: const Text(
            'Group B',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow[800],
        ),
        Icon(
          Icons.star,
          color: Colors.yellow[800],
        ),
        Icon(
          Icons.star,
          color: Colors.yellow[800],
        ),
        const Icon(
          Icons.star,
          color: Colors.black,
        ),
        const Icon(
          Icons.star,
          color: Colors.black,
        ),
      ],
    );
    var ratings = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          const Text(
            '170 Reviews',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto',
                letterSpacing: 0.5,
                fontSize: 20),
          )
        ],
      ),
    );
    const descTextStyle = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 18,
        height: 2);
    var iconList = DefaultTextStyle(
        style: descTextStyle,
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: const [
                    Icon(
                      Icons.kitchen,
                      color: Colors.green,
                    ),
                    Text('PREP:'),
                    Text('25 min'),
                  ],
                ),
                Column(
                  children: const [
                    Icon(
                      Icons.timer,
                      color: Colors.green,
                    ),
                    Text('COOK:'),
                    Text('1 hr'),
                  ],
                ),
                Column(
                  children: const [
                    Icon(
                      Icons.restaurant,
                      color: Colors.green,
                    ),
                    Text('FEEDS:'),
                    Text('4-6'),
                  ],
                )
              ],
            )));
    var leftColumn = Container(
      // padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [ratings, iconList],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('布局'),
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'images/1@2x.png',
                    width: 100,
                  ),
                  Image.asset(
                    'images/1@2x.png',
                    width: 100,
                  ),
                  Image.asset(
                    'images/1@2x.png',
                    width: 100,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/1@2x.png',
                    width: 100,
                  ),
                  Expanded(
                    child: Image.asset(
                      'images/1@2x.png',
                      width: 100,
                    ),
                    flex: 2,
                  ),
                  Image.asset(
                    'images/1@2x.png',
                    width: 100,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                // height: 400,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 8,
                        child: leftColumn,
                      ),
                      // mainImage,
                    ],
                  ),
                ),
              ),
              _buildStack(),
            ],
          ),
        )));
  }
}

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListTile _tile(String title, String subtitle, IconData icon) {
      return ListTile(
        title: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    Widget _buildList() {
      return ListView(
        children: [
          _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
          _tile('The Castro Theater', '429 Castro St', Icons.theaters),
          _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
          _tile('Roxie Theater', '3117 16th St', Icons.theaters),
          _tile('United Artists Stonestown Twin', '501 Buckingham Way',
              Icons.theaters),
          _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
          const Divider(),
          _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
          _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
          _tile(
              'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
          _tile('La Ciccia', '291 30th St', Icons.restaurant),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('列表'),
      ),
      body: _buildList(),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 40;

  void _toggleFavorite() {
    setState(() {
      _favoriteCount += (_isFavorited ? -1 : 1);
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            icon: _isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }
}

class LayoutTutorial extends StatelessWidget {
  const LayoutTutorial({Key? key}) : super(key: key);

  Widget _getButtonItem(IconData icon, Color color, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Oeschinen Lake Campground',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          )),
          const FavoriteWidget(),
        ],
      ),
    );
    Widget buttonSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getButtonItem(Icons.call, Colors.blue, 'CALL'),
          _getButtonItem(Icons.near_me, Colors.blue, 'ROUTE'),
          _getButtonItem(Icons.share, Colors.blue, 'SHARE'),
        ],
      ),
    );
    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('布局教程'),
      ),
      body: ListView(
        children: [
          // Image.asset(
          //   'images/1@2x.png',
          //   width: MediaQuery.of(context).size.width,
          //   height: 240,
          //   fit: BoxFit.cover,
          // ),
          Image.network(
            'https://api.dujin.org/bing/1366.php',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection,
        ],
      ),
    );
  }
}

class ConstraintsPage extends StatelessWidget {
  const ConstraintsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('布局约束'),
      ),
      // body: Align(
      //   alignment: Alignment.center,
      //   child: Container(
      //     color: Colors.red,
      //     // width: double.infinity,
      //     // height: double.infinity,
      //     child: Container(
      //       color: Colors.green,
      //       width: 50,
      //       height: 50,
      //     ),
      //   ),
      // ),
      // body: ConstrainedBox(
      //   // ConstrainedBox 将 constraints 参数带来的约束附加到其子对象上。
      //   // 子对象大小小于约束最小值时取最小值，大于最大值时取最大值，介于两者之间时取原来尺寸
      //   constraints: const BoxConstraints(
      //       minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
      //   child: Container(
      //     color: Colors.red,
      //     width: 100,
      //     height: 100,
      //   ),
      // ),
      // body: OverflowBox(
      //   //UnconstrainedBox(
      //   child: Container(
      //     color: Colors.red,
      //     width: 4000,
      //     height: 50,
      //   ),
      // ),
      body: const FittedBox(
        child: Text('Some Example Text.'),
      ),
    );
  }
}

// class UserModel {
//   String name = 'Jimi';
//   void changeName() {
//     name = 'hello';
//   }
// }
class UserModel extends ChangeNotifier {
  String name = 'Jimi';
  void changeName() {
    name = 'hello';
    notifyListeners();
  }
}

class ProviderExample extends StatelessWidget {
  const ProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Provider<UserModel>(
    //   create: (_) => UserModel(),
    //   child: const ProviderPage(),
    // );
    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel(),
      child: const ProviderPage(),
    );
  }
}

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProviderExample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserModel>(builder: (_, userModel, child) {
              return Text(
                '获取到Provider中的值：${userModel.name}',
                style: const TextStyle(color: Colors.red, fontSize: 20),
              );
            }),
            Consumer<UserModel>(builder: (_, userModel, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      userModel.changeName();
                    },
                    child: const Text('改变Provider中的值')),
              );
            })
          ],
        ),
      ),
    );
  }
}
