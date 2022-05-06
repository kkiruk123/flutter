import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppingcart/components/cartProvider.dart';
import 'package:flutter_shoppingcart/constants.dart';
import 'package:provider/provider.dart';

class cartPage extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: itemListView(),
    );
  }
}

class eachItem extends StatelessWidget {
  eachItem(this._item);

  final cartItem _item;

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

class headerTile extends StatelessWidget {
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

class itemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: context.read<cartProvider>().items.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return headerTile();
        } else {
          return eachItem(context.read<cartProvider>().items[index - 1]);
        }
      },
    );
  }
}
