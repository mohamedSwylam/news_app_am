import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/modules/search/search_screen.dart';
import 'package:news_app_am/shared/components/components.dart';

import 'cubit/cubit/cubit.dart';
import 'cubit/states/states.dart';

class NewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit, NewStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('New Screen'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen(),);
                  },
                ),
                IconButton(
                    onPressed: () {
                      NewCubit.get(context).changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4_sharp))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItem,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
