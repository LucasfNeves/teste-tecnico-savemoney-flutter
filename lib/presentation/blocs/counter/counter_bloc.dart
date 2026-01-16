import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/counter/counter_event.dart';
import 'package:teste_create_flutter/presentation/blocs/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterValue(0)) {
    on<IncrementCounter>((event, emit) {
      final currentValue = state as CounterValue;
      emit(CounterValue(currentValue.counter + 1));
    });

    on<DecrementCounter>((event, emit) {
      final currentValue = state as CounterValue;
      emit(CounterValue(currentValue.counter - 1));
    });

    on<ResetarContador>((event, emit) {
      emit(CounterValue(0));
    });
  }

  void increment() => add(const IncrementCounter());
  void decrement() => add(const DecrementCounter());
  void reset() => add(const ResetarContador());
}
