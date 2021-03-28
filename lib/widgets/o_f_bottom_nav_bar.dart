import 'package:flutter/material.dart';

class OFBottomNavBar extends StatefulWidget {
  OFBottomNavBar({Key? key}) : super(key: key);

  @override
  _OFBottomNavBarState createState() => _OFBottomNavBarState();
}

class _OFBottomNavBarState extends State<OFBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: Icon(Icons.monetization_on_outlined), onPressed: () {},),
        IconButton(icon: Icon(Icons.star), onPressed: () {},),
        IconButton(icon: Icon(Icons.bookmark), onPressed: () {},),
        IconButton(icon: Icon(Icons.settings), onPressed: () {},),
      ],
    );
  }
}