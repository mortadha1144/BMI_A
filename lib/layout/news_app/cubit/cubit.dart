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
      label: 'Business'
      ,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports'
      ,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science'
      ,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings'
      ,
    ),
  ];

  List<StatelessWidget> screens =[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int value){
    currentIndex=value;
    emit(NewsBottomNavState());
  }

  List<dynamic> business =[];

  void getBusiness(){
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
      business=value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
}
