import 'package:covid19_app/bloc/covid_bloc.dart';
import 'package:covid19_app/bloc/covid_events.dart';
import 'package:covid19_app/bloc/covid_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgtes/reuse_card_row.dart';
import '../widgtes/round_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'countries_list.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    BlocProvider.of<CovidBloc>(context).add(FetchDataEvent());
    animationController =
        AnimationController(duration: (Duration(seconds: 3)), vsync: this);

    animationController.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final colorList = <Color>[
    Colors.red,
    Colors.yellowAccent,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CovidBloc, CovidState>(
        builder: (context, state) {
          if (state is InitialState) {
            return Container();
          } else if (state is CovidIsLoading) {
            return Center(
              child: SpinKitFadingCircle(
                controller: animationController,
                size: 50,
                color: Colors.white,
              ),
            );
          } else if (state is CovidIsLoaded) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    PieChart(
                      dataMap: {
                        'Total':
                            double.parse(state.covidModel.cases.toString()),
                        'Recovered': double.parse(
                            state.covidModel.recovered.toString()),
                        'Deaths':
                            double.parse(state.covidModel.deaths.toString()),
                      },
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartRadius: MediaQuery.of(context).size.width / 2.3,
                      animationDuration: Duration(microseconds: 1200),
                      legendOptions:
                          LegendOptions(legendPosition: LegendPosition.left),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Card(
                      child: Column(
                        children: [
                          ReuseRowCard(
                            title: 'Total',
                            value: state.covidModel.cases.toString(),
                          ),
                          ReuseRowCard(
                            title: 'Deaths',
                            value: state.covidModel.deaths.toString(),
                          ),
                          ReuseRowCard(
                            title: 'Recovered',
                            value: state.covidModel.recovered.toString(),
                          ),
                          ReuseRowCard(
                            title: 'Active',
                            value: state.covidModel.active.toString(),
                          ),
                          ReuseRowCard(
                            title: 'Critical',
                            value: state.covidModel.critical.toString(),
                          ),
                          ReuseRowCard(
                            title: "Today's Deaths",
                            value: state.covidModel.todayDeaths.toString(),
                          ),
                          ReuseRowCard(
                            title: "Today's Recovered",
                            value: state.covidModel.todayRecovered.toString(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RoundButton(
                      title: 'Track Countries',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<CovidBloc>.value(
                                      value: CovidBloc(),
                                      child: CountriesListScreen())),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CovidIsNotLoaded) {
            return Container(
              child: Center(
                child: Text(
                  state.error.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
