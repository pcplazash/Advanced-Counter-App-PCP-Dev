import 'package:advanced_counter_app/logic/cubit/second_counter/second_counter_cubit.dart';
import 'package:advanced_counter_app/logic/cubit/second_counter/second_counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StepSetter extends StatelessWidget {
  const StepSetter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondCounterCubit, SecondCounterState>(
      builder: (context, state) => Container(
        width: 200,
        height: 88,
        color: Colors.transparent.withOpacity(0.2),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Set your stepper',
              style: GoogleFonts.jost(
                fontSize: 14,

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      context
                          .read<SecondCounterCubit>()
                          .decrementSecondCounter();
                    },
                    child: const Icon(Icons.remove)),
                Text(
                  context
                      .select((SecondCounterCubit secondCounterCubit) =>
                          secondCounterCubit.state.secondCounter)
                      .toString(),
                  style: GoogleFonts.jost(
                    fontSize: 14,

                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      context
                          .read<SecondCounterCubit>()
                          .incrementSecondCounter();
                    },
                    child: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
