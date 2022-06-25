import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//每个列表项model
@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length],
        price = id % Colors.primaries.length;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}

//列表页面总的model
class CatalogModel {
  //Colors.primaries
  static List<String> itemNames = [
    'red',
    'pink',
    'purple',
    'deepPurple',
    'indigo',
    'blue',
    'lightBlue',
    'cyan',
    'teal',
    'green',
    'lightGreen',
    'lime',
    'yellow',
    'amber',
    'orange',
    'deepOrange',
    'brown',
    'blueGrey',
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

class MyCatalog extends StatelessWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _MyAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((context, index) => _MyListItem(
                        index: index,
                      ))),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  const _MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Catalog',
        style: Theme.of(context).textTheme.headline4,
      ),
      floating: false,
      pinned: true, //阻止Appbar隐藏
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart)),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  const _MyListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    // 从CatalogModel中找到Item
    var item = context
        .select<CatalogModel, Item>((catalog) => catalog.getByPosition(index));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: Text(item.name,
                    style: Theme.of(context).textTheme.headline6)),
            const SizedBox(
              width: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('\$${item.price.toString()}',
                  style: const TextStyle(fontSize: 16)),
            ),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart =
        context.select<CartModel, bool>((cart) => cart.items.contains(item));
    return TextButton(
        onPressed: isInCart
            ? () {
                var cart = context.read<CartModel>();
                cart.remove(item);
              }
            : () {
                var cart = context.read<CartModel>();
                cart.add(item);
              },
        style: isInCart
            ? null
            : ButtonStyle(overlayColor:
                MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).primaryColor;
                }
                return null;
              })),
        child: isInCart
            ? const Icon(
                Icons.check,
                semanticLabel: 'ADDED',
              )
            : const Text('ADD'));
  }
}

//购物车页面总的modal
class CartModel extends ChangeNotifier {
  /// The private field backing [catalog].
  late CatalogModel _catalog;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _itemIds.add(item.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline4,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: const [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: _CartList(),
            )),
            Divider(
              height: 4,
              color: Colors.black,
            ),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return ListView.builder(
        itemCount: cart.items.length * 2,
        itemBuilder: (context, index) => index.isOdd
            ? const Divider()
            : ListTile(
                // leading: const Icon(Icons.done),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    cart.remove(cart.items[index ~/ 2]);
                  },
                ),
                title: Text(
                  '${cart.items[index ~/ 2].name}   '
                  '\$${cart.items[index ~/ 2].price}',
                  style: TextStyle(
                      fontSize: 20, color: cart.items[index ~/ 2].color),
                ),
              ));
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return SizedBox(
      height: 60,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Consumer<CartModel>(
            //     builder: (context, cart, child) => Text(
            //           '\$${cart.totalPrice}',
            //           style: Theme.of(context).textTheme.headline3,
            //         )),
            Text(
              '\$${cart.totalPrice}',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              width: 24,
            ),
            TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Buying not supported yet.')));
                },
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.red),
                child: const Text('BUY')),
          ],
        ),
      ),
    );
  }
}
