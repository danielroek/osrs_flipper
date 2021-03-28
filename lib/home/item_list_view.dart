import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrs_flipper/data_bloc/data_bloc.dart';
import 'package:osrs_flipper/data_bloc/model/flip_item.dart';

class ItemListView extends StatefulWidget {
  ItemListView({Key? key}) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
        bloc: BlocProvider.of<DataBloc>(context),
        builder: (context, state) {
          if (state is HasDataState) {
            return ListView(
              children: _buildItems(state),
            );
          } else {
            return Container();
          }
        },
    );
  }

  List<Widget> _buildItems(HasDataState state) {
    return List<Widget>.of(() sync* {
      for (final FlipItem item in state.items) {
        yield Card(
          child: ListTile(title: Text(item.name),),
        );
      }
    }());
  }
}