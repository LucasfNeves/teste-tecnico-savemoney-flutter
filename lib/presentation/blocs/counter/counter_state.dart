import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {}

class CounterValue extends CounterState {
  final int counter;

  @override
  List<Object> get props => [counter];

  const CounterValue(this.counter);
}
