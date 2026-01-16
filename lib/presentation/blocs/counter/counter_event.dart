import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounter extends CounterEvent {
  const IncrementCounter();
}

class DecrementCounter extends CounterEvent {
  const DecrementCounter();
}

class ResetarContador extends CounterEvent {
  const ResetarContador();
}
