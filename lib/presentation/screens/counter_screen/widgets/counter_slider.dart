import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/counter_cubit/counter_cubit.dart';
import 'my_stepper.dart';

class CounterSlider extends StatelessWidget {
  const CounterSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(

      builder: (context, state) => MyStepper(
        initialValue: 0,
        speedTransitionLimitCount: 10,
        firstIncrementDuration: const Duration(milliseconds: 300),
        secondIncrementDuration: const Duration(milliseconds: 100),
        direction: Axis.horizontal,
        dragButtonColor: Theme.of(context).colorScheme.primary,
        withSpring: true,
        maxValue: 1000,
        minValue: -1000,
        withFastCount: true,
        onChanged: (int val) {},
        stepperValue: 5,
      ),
    );
  }
}
