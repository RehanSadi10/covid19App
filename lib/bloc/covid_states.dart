import 'package:covid19_app/repository/Covid_model.dart';

class CovidState {}

class InitialState extends CovidState {}

class CovidIsLoading extends CovidState {}

class CovidIsLoaded extends CovidState {
  CovidModel covidModel;

  CovidIsLoaded({required this.covidModel});
}

class CovidIsNotLoaded extends CovidState {
  String error;

  CovidIsNotLoaded({required this.error});
}

//Country Loading

class CountryIsLoading extends CovidState {}

class CountryIsLoaded extends CovidState {
  List<dynamic> list = [];
  CountryIsLoaded({required this.list});
}

class CountryIsNotLoaded extends CovidState {
  String error;
  CountryIsNotLoaded(this.error);
}
