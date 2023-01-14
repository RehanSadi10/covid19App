import 'package:covid19_app/bloc/covid_bloc.dart';
import 'package:flutter/material.dart';
import 'splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
      create: (BuildContext context) => CovidBloc(),
      child: const Covid19App())
  );
}

class Covid19App extends StatelessWidget {
  const Covid19App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
