import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:udemy/modules/business/business_screen.dart';
import 'package:udemy/modules/science/science_screen.dart';
import 'package:udemy/modules/settings/settings_screen.dart';
import 'package:udemy/modules/sports/sport_screen.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<StatelessWidget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNav(int value) {
    currentIndex = value;

    if (value == 1) {
      getSports();
    }
    if (value == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '7963b3318b6f4b82a4569760983b2d15',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'].toString());
      business = value?.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '7963b3318b6f4b82a4569760983b2d15',
        },
      ).then((value) {
        //print(value?.data['articles'][0]['title'].toString());
        sports = value?.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '7963b3318b6f4b82a4569760983b2d15',
        },
      ).then((value) {
        //print(value?.data['articles'][0]['title'].toString());
        science = value?.data['articles'];
        //print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }
  void getSearch(String value) {


    emit(NewsGetSearchLoadingState());
    search=[];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '7963b3318b6f4b82a4569760983b2d15',
      },
    ).then((value) {
      //print(value?.data['articles'][0]['title'].toString());
      search = value?.data['articles'];
      //print(science[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }
}
