import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutterbleapp/app/models/glucose_model.dart';

import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    try {
      store.convertData(
        store.response,
        // store.glucoseContextList,
      );
    } catch (e) {
      log('deu ruim');
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange[300],
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              store.convertData(
                store.response,
                // store.glucoseContextList,
              );

              Navigator.of(context).pushNamed(
                '/glucose',
              );
            },
            icon: Icon(
              Icons.bluetooth,
              color: Colors.grey[600],
            ),
          ),
          IconButton(
            onPressed: () async {
              // store.convertData(store.response, store.glucoseContextList);

              // Navigator.of(context).pushNamed(
              //   '/devices',
              // );
              // int i = 2021 - 1792;
              // print(i.toRadixString(16));
              // print(store.response);
              print(utf8.encode('dc070605100731'));
            },
            icon: Icon(
              Icons.bluetooth_connected,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      body: ScopedBuilder<HomeStore, Exception, BluetoothDeviceState>(
        store: store,
        onLoading: (_) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        onState: (_, connectionState) {
          return StreamBuilder<List<BluetoothDevice>>(
            // stream: Stream.periodic(
            //   Duration(seconds: 4),
            // ).asyncMap(
            //   // ignore: missing_return
            //   // (_) {
            //   //   print('buscando dispositivo');
            //   //   if (store.state == BluetoothDeviceState.disconnected) {
            //   //     store.receiveData();
            //   //   }
            //   // },
            // ),
            builder: (c, snapshot) {
              return RefreshIndicator(
                color: Colors.orange[300],
                onRefresh: () async {},
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200]),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text('Última Medição Realizada!',
                                          style: TextStyle(fontSize: 25)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      store.data.length > 0
                                          ? Text(
                                              store.data.last.measurement
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              '0',
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              store.data.length > 0
                                  ? Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                              'Histórico de Medição de Glicose'),
                                          Flexible(
                                            child: charts.TimeSeriesChart(
                                              _getSeriesData(),
                                              animate: false,
                                              behaviors: [
                                                // new charts.RangeAnnotation(
                                                //   [
                                                //     charts.RangeAnnotationSegment(
                                                //       0,
                                                //       49,
                                                //       charts.RangeAnnotationAxisType.measure,
                                                //       labelAnchor: charts.AnnotationLabelAnchor.start,
                                                //       color: charts.MaterialPalette.white.darker,
                                                //     ),
                                                //   ],
                                                // ),
                                                charts.LinePointHighlighter(
                                                    showHorizontalFollowLine: charts
                                                        .LinePointHighlighterFollowLineType
                                                        .none,
                                                    showVerticalFollowLine: charts
                                                        .LinePointHighlighterFollowLineType
                                                        .nearest),
                                                charts.SelectNearest(
                                                    eventTrigger: charts
                                                        .SelectionTrigger
                                                        .tapAndDrag)
                                              ],
                                              defaultRenderer:
                                                  charts.LineRendererConfig(
                                                includePoints: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _getSeriesData() {
    List<charts.Series<GlucoseModel, DateTime>> series = [
      charts.Series(
        id: "Sales",
        data: store.data,
        domainFn: (GlucoseModel glucoseData, _) => glucoseData.data,
        measureFn: (GlucoseModel glucoseData, _) => glucoseData.measurement,
        colorFn: (GlucoseModel glucoseData, _) => charts.MaterialPalette.black,
      )
    ];
    return series;
  }
}

class GlucoseData {
  final int glucose;
  final DateTime data;

  GlucoseData(this.glucose, this.data);
}
