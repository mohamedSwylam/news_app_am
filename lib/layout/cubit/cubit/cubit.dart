import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/layout/cubit/states/states.dart';
import 'package:news_app_am/modules/Sports/sports_screen.dart';
import 'package:news_app_am/modules/business_screen/bussiness_screen.dart';
import 'package:news_app_am/modules/science/science_screen.dart';
import 'package:news_app_am/shared/network/local/cache_helper.dart';
import 'package:news_app_am/shared/network/remote/dio_helper.dart';

class NewCubit extends Cubit<NewStates> {
  NewCubit() : super(NewIntialState());

  static NewCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball_outlined),
      label: 'Sports',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  void changeBottomNavBar(int index) {
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    currentIndex = index;
    emit(NewChangeBottomNavBarrState());
  }

  List <dynamic> business = [];
  List <dynamic> sports = [];
  List <dynamic> science = [];
  List <dynamic> search = [];

  void getBusiness() {
    emit(NewGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '8cf81d92f5a346f69140cfd65f1c2d47',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '8cf81d92f5a346f69140cfd65f1c2d47',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'Science',
          'apiKey': '8cf81d92f5a346f69140cfd65f1c2d47',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewGetScienceSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '8cf81d92f5a346f69140cfd65f1c2d47',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetSearchErrorState(error.toString()));
    });
  }
  bool isDark = false;

  void changeAppMode({bool fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(NewAppChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewAppChangeModeState());
      });
    }
  }
}