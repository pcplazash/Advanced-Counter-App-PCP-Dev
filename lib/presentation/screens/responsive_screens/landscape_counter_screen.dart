import '../../../barrel.dart';
import '../counter_screen/widgets/counter_slider.dart';
import '../counter_screen/widgets/custom_box.dart';
import '../counter_screen/widgets/particles_animation.dart';
import '../counter_screen/widgets/step_setter.dart';

class LandscapeCounterScreen extends StatelessWidget {
  const LandscapeCounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final color = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        const ParticlesAnimation(),
        const CustomBox(),
        Positioned(
          top: height * 0.11,
          left: height * 0.96,
          child: BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) => Text(
              context
                  .select(
                      (CounterCubit counterCubit) => counterCubit.state.counter)
                  .toString(),
              style: TextStyle(color: color.outline, fontSize: 50),
            ),
          ),
        ),
        Positioned(
          right: height * 0.2,
          bottom: height * 0.1,
          child: const Column(children: [
            CounterSlider(),
            SizedBox(height: 10),
          ]),
        ),
        Positioned(
          left: height * 0.2,
          bottom: height * 0.1,
          child: Column(
            children: [
              const StepSetter(),
              const SizedBox(height: 17),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).particlesColor),
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Color(0xffFF5D00)),
                ),
                onPressed: () {
                  context.read<CounterCubit>().resetCounter();
                  context.read<SecondCounterCubit>().resetSecondCounter();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
