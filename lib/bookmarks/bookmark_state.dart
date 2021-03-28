part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();
}

class BookmarkInitial extends BookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkListState extends BookmarkState {
  final List<FlipItem> items;

  BookmarkListState(this.items);

  @override
  List<Object?> get props => items;
}