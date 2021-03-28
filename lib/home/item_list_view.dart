import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osrs_flipper/data_bloc/data_bloc.dart';
import 'package:osrs_flipper/data_bloc/model/flip_item.dart';

class ItemListView extends StatefulWidget {
  ItemListView({Key? key}) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  void initState() {
    super.initState();
  }

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
          child: ListTile(
            trailing: IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                //TODO: Bookmark item
              },
            ),
            // leading:  (imageUrl: 'https://www.osrsbox.com/osrsbox-db/items-icons/${item.id}.png', width: 75, height: 75,),
            leading:  Image(image: CachedNetworkImageProvider('https://www.osrsbox.com/osrsbox-db/items-icons/${item.id}.png')),
            title: Text(item.name),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'sell: ${NumberFormat.currency(locale: 'nl-NL', symbol: '', decimalDigits: 0).format(item.high ?? 0)}'),
                    Text(
                        'buy: ${NumberFormat.currency(locale: 'nl-NL', symbol: '', decimalDigits: 0).format(item.low ?? 0)}'),
                    Text(
                        'LPV: ${NumberFormat.currency(locale: 'nl-NL', symbol: '', decimalDigits: 0).format(item.lowPriceVolume ?? 0)}')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'limit: ${NumberFormat.currency(locale: 'nl-NL', symbol: '', decimalDigits: 0).format(item.buyLimit ?? 0)}'),
                    Text('roi: ${(item.roi ?? 0).toStringAsFixed(2)}%'),
                    Text(
                        'HPV: ${NumberFormat.currency(locale: 'nl-NL', symbol: '', decimalDigits: 0).format(item.highPriceVolume ?? '')}'),
                  ],
                )
              ],
            ),
          ),
        );
      }
    }());
  }
}
