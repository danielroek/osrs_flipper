part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();
}

class DataInitial extends DataState {
  @override
  List<Object> get props => [];
}

class HasDataState extends DataState {
  final List<FlipItem> items;

  HasDataState(
      {this.items = const [FlipItem(111, 0.01, 100, 101, 10000, 'TestItem')]});

  @override
  List<Object> get props => items;
}
