import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OFBottomNavBar extends StatefulWidget {
  OFBottomNavBar({Key? key}) : super(key: key);

  @override
  _OFBottomNavBarState createState() => _OFBottomNavBarState();
}

class _OFBottomNavBarState extends State<OFBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.monetization_on_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                Navigator.of(context).pushNamed('/bookmarks');
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
