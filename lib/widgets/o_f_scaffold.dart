import 'package:flutter/material.dart';
import 'package:osrs_flipper/widgets/o_f_bottom_nav_bar.dart';

class OFScaffold extends StatefulWidget {
  final Widget body;
  OFScaffold({Key? key, required this.body}) : super(key: key);

  @override
  _OFScaffoldState createState() => _OFScaffoldState();
}

class _OFScaffoldState extends State<OFScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: OFBottomNavBar(),
      body: SingleChildScrollView(child: widget.body),
    );
  }
}