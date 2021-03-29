import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osrs_flipper/data_bloc/model/flip_item.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  List<FlipItem> bookmarks= [];
  String bookmarkKey = 'bookmarkKey';
  final _store = GetStorage();
  BookmarkBloc() : super(BookmarkInitial()) {
    bookmarks = _loadBookmarks();
  }

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
  if (event is AddBookmark) {
    yield* _handleAddBookmark(event);
  }
  if (event is RemoveBookmark) {
    yield* _handleRemoveBookmark(event);
  }
  }

  Stream<BookmarkState> _handleAddBookmark(AddBookmark event) async* {
    bookmarks.add(event.savedItem);
    await _store.write(bookmarkKey, bookmarks);
    await _store.save();
    yield BookmarkListState(bookmarks);
  }

  Stream<BookmarkState> _handleRemoveBookmark(RemoveBookmark event) async* {
    print("removing item");
    print(event.id.toString());
    bookmarks.removeWhere((element) => element.id == event.id);
    await _store.write(bookmarkKey, bookmarks);
    await _store.save();

    yield BookmarkListState(bookmarks);
  }

  List<FlipItem> _loadBookmarks() {
    bookmarks = [];
    (_store.read(bookmarkKey) as List<dynamic>? ?? []).forEach((e) {
      bookmarks.add(FlipItem.fromJson(e));
    });
    return bookmarks;
  }
}
