import 'package:covid19_app/bloc/covid_bloc.dart';
import 'package:covid19_app/bloc/covid_states.dart';
import 'package:covid19_app/screens/detail_screen.dart';
import 'package:covid19_app/screens/world_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/covid_events.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CovidBloc>(context).add(FetchCountries());

    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocBuilder<CovidBloc, CovidState>(
        builder: (context, state) {
          if (state is CountryIsLoading) {
            return Center(
              child: SpinKitFadingCircle(
                controller: animationController,
                size: 50,
                color: Colors.white,
              ),
            );
          } else if (state is CountryIsLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Enter the country name ...',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        if (searchController.text.isEmpty) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contetx) => DetailScreen(
                                          name: state.list[index]['country'],
                                          img: state.list[index]['countryInfo']
                                              ['flag'],
                                          cases: state.list[index]['cases'],
                                          deaths: state.list[index]['deaths'],
                                          recovered: state.list[index]
                                              ['recovered'],
                                          active: state.list[index]['active'],
                                          critical: state.list[index]
                                              ['critical'])));
                            },
                            leading: Container(
                                height: 100,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      state.list[index]['countryInfo']['flag']),
                                ))),
                            title: Text(
                              state.list[index]['country'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              state.list[index]['cases'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        } else if (state.list[index]['country']
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contetx) => DetailScreen(
                                          name: state.list[index]['country'],
                                          img: state.list[index]['countryInfo']
                                              ['flag'],
                                          cases: state.list[index]['cases'],
                                          deaths: state.list[index]['deaths'],
                                          recovered: state.list[index]
                                              ['recovered'],
                                          active: state.list[index]['active'],
                                          critical: state.list[index]
                                              ['critical'])));
                            },
                            leading: Container(
                                height: 100,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      state.list[index]['countryInfo']['flag']),
                                ))),
                            title: Text(
                              state.list[index]['country'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              state.list[index]['cases'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
