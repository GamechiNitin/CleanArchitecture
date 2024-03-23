import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/common/cubits/app_user/app_user_cubit.dart';
import 'package:project_x1_news/init_dependencies.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/view/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project_x1_news/view/features/home/presentation/home_screen.dart';
import 'view/features/auth/presentation/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthSessionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) => state is AppUserLoggedIn,
        builder: (context, state) {
          if (state) {
            return const HomeScreen();
          } else {
            return const LogInScreen();
          }
        },
      ),
    );
  }
}
