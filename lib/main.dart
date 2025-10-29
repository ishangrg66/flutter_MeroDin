import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/core/theme/app_theme.dart';
import 'package:mero_din_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/bloc/approve_team_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_bloc.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:mero_din_app/features/teamInfo/presentation/bloc/team_info_bloc.dart';
import 'package:mero_din_app/injection_container.dart';
import 'package:mero_din_app/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TeamInfoBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<CurrentTeamInfoBloc>()),
        BlocProvider(create: (_) => sl<UserSearchBloc>()),
        BlocProvider(create: (_) => sl<ApproveTeamBloc>()),
        BlocProvider(create: (_) => sl<ScheduleBloc>()),
        BlocProvider(create: (_) => sl<CurrentUserBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Clean Calendar',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
