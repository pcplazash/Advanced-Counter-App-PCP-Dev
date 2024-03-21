part of 'counter_cubit.dart';

class CounterState extends Equatable {

  final int counter;

  CounterState({required this.counter});


  @override
  List<Object> get props => [counter];

  @override
  String toString() {
    return 'CounterState{counter: $counter}';
  }

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counter: map['counter'] as int,
    );
  }

  String toJson() => json.encode(toMap());

 factory CounterState.fromJson(String source) => CounterState.fromMap (json.decode(source));


}












