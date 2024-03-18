import 'package:flutter/material.dart';
import 'package:project_x1_news/utils/app_colors.dart';

import 'core/error/secrets.dart';
import 'view/features/auth/presentation/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: AppSecrets.sKr, anonKey: AppSecrets.anon);
  runApp(const MyApp());
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
