import 'package:flutter/material.dart';
import 'package:osrs_flipper/bookmarks/bookmark_item_list_view.dart';
import 'package:osrs_flipper/data_bloc/model/filter_options.dart';
import 'package:osrs_flipper/home/item_list_view.dart';
import 'package:osrs_flipper/widgets/o_f_scaffold.dart';

class BookmarksView extends StatefulWidget {
  BookmarksView({Key? key}) : super(key: key);

  @override
  _BookmarksViewState createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  @override
  Widget build(BuildContext context) {
    return OFScaffold(
      fab: FloatingActionButton.extended(
        icon: Icon(Icons.filter_alt_outlined),
        label: Text('Filter'),
        onPressed: () {
          _showFilterModal(context);
        }, ),
      body: BookmarkItemListView(),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet<FilterOptions>(
        context: context,
        builder: (context) {
          return Container();
        });
  }
}
