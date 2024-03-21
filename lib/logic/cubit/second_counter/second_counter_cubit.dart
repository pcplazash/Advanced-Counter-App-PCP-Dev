import 'package:advanced_counter_app/logic/cubit/second_counter/second_counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondCounterCubit extends Cubit<SecondCounterState> {
  SecondCounterCubit() : super(SecondCounterState(secondCounter: 1));

  void incrementSecondCounter() {
    emit(state.copyWith(secondCounter: state.secondCounter + 1));
  }

  void decrementSecondCounter() {
    emit(state.copyWith(secondCounter: state.secondCounter - 1));
  }

  void resetSecondCounter(){
    emit(state.copyWith(secondCounter: 1));
  }
}
