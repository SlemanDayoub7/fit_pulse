import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/constants/application_constants.dart';
import 'package:gym_app/core/constants/asset_paths.dart';
import 'package:gym_app/core/constants/shared_pref_keys.dart';
import 'package:gym_app/core/di/dependency_injection.dart' as Bindings;
import 'package:gym_app/core/helpers/extensions.dart';
import 'package:gym_app/core/helpers/shared_pref_helper.dart';
import 'package:gym_app/core/local_notifiaction/local_notifiaction_service.dart';
import 'package:gym_app/core/localization/localization_service.dart';
import 'package:gym_app/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:gym_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:gym_app/features/nutrition/presentation/bloc/nutrition_plans_bloc.dart';

import 'package:gym_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:gym_app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:gym_app/features/private_workout/presentation/bloc/workout_program_cubit.dart';

import 'package:gym_app/features/weight_tracker/data/data_sources/weight_entry_model.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/reminder/reminder_bloc.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight/weight_bloc.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight/weight_event.dart';
import 'package:gym_app/features/weight_tracker/presentation/pages/add_weight_page.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_bloc.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_bloc.dart';
import 'package:gym_app/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym_app/core/di/dependency_injection.dart' as di;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppTheme {
  static ThemeData get light {
    const primaryColor = Color(0xFFE0AD00);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      fontFamily: 'Consolas',
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bindings.init();

  await LocalizationService.initLocalization();
  final prefs = await SharedPreferences.getInstance();
  await checkIfLoggedInUser();
  final notificationService = NotificationService(navigatorKey: navigatorKey);
  await notificationService.init();
  final dataSource = LocalDataSource(prefs);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  // Hive.registerAdapter(WorkoutProgramAdapter());
  // Hive.registerAdapter(ExerciseAdapter());
  // await Hive.openBox<WorkoutProgram>('workout_programs');

  runApp(EasyLocalization(
      supportedLocales: LocalizationService.supportedLocales,
      path: AssetPaths.translationsPath,
      fallbackLocale: LocalizationService.enLocale,
      startLocale: Locale('ar'),
      child: MyApp(
        dataSource: dataSource,
        reminderService: notificationService,
      )));
}

class MyApp extends StatelessWidget {
  final LocalDataSource dataSource;
  final NotificationService reminderService;

  MyApp({super.key, required this.dataSource, required this.reminderService});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<NutritionPlansBloc>(
              create: (_) => di.sl<NutritionPlansBloc>()),
          BlocProvider<SportsBloc>(create: (_) => di.sl<SportsBloc>()),
          BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
          BlocProvider(
            create: (_) => WeightBloc(dataSource)..add(LoadWeightEntries()),
          ),
          BlocProvider(
            create: (_) => ReminderBloc(reminderService),
          ),
          BlocProvider<WorkoutPlansBloc>(
            create: (_) => di.sl<WorkoutPlansBloc>(),
            child: Container(),
          ),
          BlocProvider(create: (_) => WorkoutProgramCubit()..loadFromLocal())
        ],
        child: MaterialApp(
          routes: {
            '/weight-entry': (_) => AddWeightPage(),
          },
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          title: ApplicationConstants.applicationName,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: SplashPage(),
        ),
      ),
    );
  }
}

checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
