import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final ValueChanged<bool> onChange;
  bool selected;

  FilterButton(
      {required this.title, required this.onChange, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(title),
      onPressed: () {
        selected = !selected;
        onChange(selected);
      },
    );
  }
}
