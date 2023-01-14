import 'package:covid19_app/screens/world_state.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../widgtes/reuse_card_row.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String img;
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int critical;
  const DetailScreen({
    Key? key,
    required this.name,
    required this.img,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.critical,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final colorList = <Color>[
    Colors.red,
    Colors.yellowAccent,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (home) => WorldStateScreen()));
            },
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image:
                        DecorationImage(image: NetworkImage(this.widget.img)),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              PieChart(
                dataMap: {
                  'Total': double.parse(this.widget.cases.toString()),
                  'Recovered': double.parse(this.widget.recovered.toString()),
                  'Deaths': double.parse(this.widget.deaths.toString()),
                },
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                animationDuration: Duration(microseconds: 1200),
                legendOptions:
                    LegendOptions(legendPosition: LegendPosition.left),
                chartType: ChartType.ring,
                colorList: colorList,
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Column(
                  children: [
                    ReuseRowCard(
                      title: 'Name',
                      value: this.widget.name,
                    ),
                    ReuseRowCard(
                      title: 'Cases',
                      value: this.widget.cases.toString(),
                    ),
                    ReuseRowCard(
                      title: 'Deaths',
                      value: this.widget.deaths.toString(),
                    ),
                    ReuseRowCard(
                      title: 'Recovered',
                      value: this.widget.recovered.toString(),
                    ),
                    ReuseRowCard(
                      title: 'Active',
                      value: this.widget.active.toString(),
                    ),
                    ReuseRowCard(
                      title: 'Critical',
                      value: this.widget.critical.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
