import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:osrs_flipper/data_bloc/model/flip_item.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitial());

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
