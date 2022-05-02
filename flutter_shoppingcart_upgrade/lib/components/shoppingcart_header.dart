import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppingcart/constants.dart';
import 'package:flutter_shoppingcart/components/idProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shoppingcart/components/idProvider.dart';

class ShoppingCartHeader extends StatefulWidget {
  @override
  _ShoppingCartHeaderState createState() => _ShoppingCartHeaderState();
}

class _ShoppingCartHeaderState extends State<ShoppingCartHeader> {
//  int selectedId = 0;

  List<String> selectedPic = [
    //  "assets/p1.jpeg",
    //  "assets/p2.jpeg",
    //  "assets/p3.jpeg",
    //  "assets/p4.jpeg",
    "assets/bicycle_black.jpeg",
    "assets/bicycle_green.jpg",
    "assets/bicycle_orange.jpg",
    "assets/bicycle_grey.jpg",
    "assets/bicycle_white.jpg",
    "assets/motor_black.jpeg",
    "assets/motor_green.jpg",
    "assets/motor_orange.jpg",
    "assets/motor_grey.jpg",
    "assets/motor_white.jpg",
    "assets/car_black.jpg",
    "assets/car_green.jpg",
    "assets/car_orange.jpg",
    "assets/car_grey.jpg",
    "assets/car_white.jpg",
    "assets/airplane_black.jpg",
    "assets/airplane_green.jpg",
    "assets/airplane_orange.jpg",
    "assets/airplane_grey.jpg",
    "assets/airplane_white.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderPic(),
        _buildHeaderSelector(),
      ],
    );
  }

  Widget _buildHeaderPic() {
    final idProviderData = Provider.of<idProvider>(context);
    final selectedId = idProviderData.selectedId;
    final colorId = idProviderData.colorId;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Image.asset(
          //selectedPic[selectedId],
          selectedPic[selectedId * 5 + colorId],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeaderSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeaderSelectorButton(0, Icons.directions_bike),
          _buildHeaderSelectorButton(1, Icons.motorcycle),
          _buildHeaderSelectorButton(2, CupertinoIcons.car_detailed),
          _buildHeaderSelectorButton(3, CupertinoIcons.airplane),
        ],
      ),
    );
  }

  // 1. 다른 화면에서도 재사용하면 공통 컴포넌트 위젯으로 관리하는 것이 좋다.
  Widget _buildHeaderSelectorButton(int id, IconData mIcon) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: id == context.read<idProvider>().selectedId
            ? kAccentColor
            : kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(mIcon, color: Colors.black),
        onPressed: () {
          setState(() {
            context.read<idProvider>().seletedIdChange(id);
          });
        },
      ),
    );
  }
}
