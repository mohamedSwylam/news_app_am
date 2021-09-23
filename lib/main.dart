import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/layout/cubit/states/states.dart';
import 'package:news_app_am/shared/network/local/cache_helper.dart';
import 'package:news_app_am/shared/network/remote/dio_helper.dart';
import 'package:news_app_am/shared/styles/themes.dart';
import 'layout/cubit/cubit/cubit.dart';
import 'layout/news_layout.dart';
import 'shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => NewCubit()..getBusiness()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<NewCubit, NewStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: NewCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: darkTheme,
          home: NewLayout(),
        ),
      ),
    );
  }
}
