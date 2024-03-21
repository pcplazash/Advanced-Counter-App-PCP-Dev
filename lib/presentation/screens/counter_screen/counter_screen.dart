import '../../../barrel.dart';

import '../responsive_screens/landscape_counter_screen.dart';
import '../responsive_screens/portrait_counter_screen.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return const PortraitCounterScreen();
          } else {
            return const LandscapeCounterScreen();
          }
        },
      ),
    );
  }
}
