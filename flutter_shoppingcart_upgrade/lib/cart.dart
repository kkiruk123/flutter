import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppingcart/components/cartProvider.dart';
import 'package:flutter_shoppingcart/constants.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ItemListView(),
    );
  }
}

class EachItem extends StatelessWidget {
  EachItem(this._item);

  final CartItem _item;

  @override
  Widget build(BuildContext context) {
    IconData listIcon = (_item.item == listItem[0])
        ? Icons.directions_bike
        : (_item.item == listItem[1])
            ? Icons.motorcycle
            : (_item.item == listItem[2])
                ? CupertinoIcons.car_detailed
                : (_item.item == listItem[3])
                    ? CupertinoIcons.airplane
                    : Icons.highlight_off;
    return ListTile(
      leading: Icon(listIcon),
      title: Text(_item.item),
      subtitle: Text(_item.itemColor),
      trailing: Text(_item.itemNum.toString()),
    );
  }
}

class HeaderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.shopping_cart),
      title: Text("Item"),
      subtitle: Text("Color"),
      trailing: Text("item Num."),
    );
  }
}

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: context.read<CartProvider>().items.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return HeaderTile();
        } else {
          return EachItem(context.read<CartProvider>().items[index - 1]);
        }
      },
    );
  }
}
