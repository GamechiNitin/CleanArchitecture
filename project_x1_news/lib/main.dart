import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/view/features/auth/data/repo/auth_repository_impl.dart';
import 'package:project_x1_news/view/features/auth/data/src/remote_data_source.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';
import 'package:project_x1_news/view/features/auth/presentation/bloc/auth_bloc.dart';

import 'core/error/secrets.dart';
import 'view/features/auth/presentation/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Supabase supabase =
      await Supabase.initialize(url: AppSecrets.sKr, anonKey: AppSecrets.anon);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(
                supabase.client,
              ),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LogInScreen(),
    );
  }
}
