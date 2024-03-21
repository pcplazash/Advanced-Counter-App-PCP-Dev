import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../second_counter/second_counter_cubit.dart';
import '../second_counter/second_counter_state.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  final SecondCounterCubit secondCounterCubit;
  late final StreamSubscription subscription;

  CounterCubit({required this.secondCounterCubit})
      : super(CounterState(counter: 0)) {
    subscription = secondCounterCubit.stream
        .listen((SecondCounterState secondCounterState) {
      incrementCounter();
      decrementCounter();
    });
  }

  void incrementCounter() {
    emit(state.copyWith(
        counter: state.counter + secondCounterCubit.state.secondCounter));
  }

  void decrementCounter() {
    emit(state.copyWith(
        counter: state.counter - secondCounterCubit.state.secondCounter));
  }

  void resetCounter(){
    emit(state.copyWith(counter: 0));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return CounterState.fromMap(json);
    }
    return CounterState(counter: 0);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
