import 'barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<SecondCounterCubit>(
          create: (context) => SecondCounterCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
              secondCounterCubit: BlocProvider.of<SecondCounterCubit>(context)),
        ),
      ],
      child: const CounterApp(),
    );
  }
}
