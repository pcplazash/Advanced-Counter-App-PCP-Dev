
import 'package:equatable/equatable.dart';



class SecondCounterState extends Equatable {
  int secondCounter;
  SecondCounterState({required this.secondCounter});

  @override
  List<Object> get props => [secondCounter];

  SecondCounterState copyWith({
    int? secondCounter,
  }) {
    return SecondCounterState(
      secondCounter: secondCounter ?? this.secondCounter,
    );
  }

  @override
  String toString() {
    return 'SecondCounterState{secondCounter: $secondCounter}';
  }
}
