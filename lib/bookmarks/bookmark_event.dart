part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

class AddBookmark extends BookmarkEvent {
  final int id;
  final FlipItem savedItem;

  AddBookmark(this.id, this.savedItem);

  @override
  List<Object?> get props => [id, savedItem];
}

class RemoveBookmark extends BookmarkEvent {
  final int id;

  RemoveBookmark(this.id);

  @override
  List<Object?> get props => [id];
}
