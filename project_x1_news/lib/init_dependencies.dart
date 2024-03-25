import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_x1_news/common/cubits/app_user/app_user_cubit.dart';
import 'package:project_x1_news/core/network/connection_checker.dart';
import 'package:project_x1_news/view/features/auth/data/repo/auth_repository_impl.dart';
import 'package:project_x1_news/view/features/auth/data/src/auth_remote_data_source.dart';
import 'package:project_x1_news/view/features/auth/domain/repository/auth_repository.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_login.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_session.dart';
import 'package:project_x1_news/view/features/auth/domain/usecases/user_signup.dart';
import 'package:project_x1_news/view/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project_x1_news/view/features/news/data/repo/news_repo_impl.dart';
import 'package:project_x1_news/view/features/news/data/src/news_local_data_source.dart';
import 'package:project_x1_news/view/features/news/data/src/news_remote_data_source.dart';
import 'package:project_x1_news/view/features/news/domain/repository/news_repository.dart';
import 'package:project_x1_news/view/features/news/domain/usecases/get_news.dart';
import 'package:project_x1_news/view/features/news/domain/usecases/upload_news.dart';
import 'package:project_x1_news/view/features/news/presentation/bloc/news_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/error/secrets.dart';

part 'init_dependencies_main.dart';
