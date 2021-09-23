abstract class NewStates {}

class NewIntialState extends NewStates {}

class NewChangeBottomNavBarrState extends NewStates {}

class NewGetBusinessSuccessState extends NewStates {}

class NewGetBusinessErrorState extends NewStates {
  final String error;

  NewGetBusinessErrorState(this.error);
}

class NewGetBusinessLoadingState extends NewStates {}

class NewGetSportsSuccessState extends NewStates {}

class NewGetSportsErrorState extends NewStates {
  final String error;

  NewGetSportsErrorState(this.error);
}

class NewGetSportsLoadingState extends NewStates {}

class NewGetScienceSuccessState extends NewStates {}

class NewGetScienceErrorState extends NewStates {
  final String error;

  NewGetScienceErrorState(this.error);
}

class NewGetScienceLoadingState extends NewStates {}

class NewGetSearchLoadingState extends NewStates {}

class NewGetSearchSuccessState extends NewStates {}

class NewGetSearchErrorState extends NewStates {
  final String error;

  NewGetSearchErrorState(this.error);
}
class NewAppChangeModeState extends NewStates {}
