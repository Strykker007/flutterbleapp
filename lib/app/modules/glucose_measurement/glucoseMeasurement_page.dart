import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterbleapp/app/modules/home/home_store.dart';

class GlucoseMeasurementPage extends StatefulWidget {
  final BluetoothDevice? device;
  const GlucoseMeasurementPage({
    Key? key,
    this.device,
  }) : super(key: key);
  @override
  GlucoseMeasurementPageState createState() => GlucoseMeasurementPageState();
}

class GlucoseMeasurementPageState extends State<GlucoseMeasurementPage> {
  HomeStore homeStore = Modular.get<HomeStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Registro de Medições',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                separatorBuilder: (_, index) {
                  return Padding(padding: EdgeInsets.all(5));
                },
                shrinkWrap: true,
                itemCount: homeStore.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Glicemia: ' +
                                homeStore.data[index].measurement.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text('Data: '),
                              Text(homeStore.data[index].data.day < 10
                                  ? '0' +
                                      homeStore.data[index].data.day
                                          .toString() +
                                      '/'
                                  : '' +
                                      homeStore.data[index].data.hour
                                          .toString() +
                                      '/'),
                              Text(homeStore.data[index].data.month < 10
                                  ? '0' +
                                      homeStore.data[index].data.month
                                          .toString()
                                  : '' +
                                      homeStore.data[index].data.month
                                          .toString()),
                              Text(
                                '/' +
                                    homeStore.data[index].data.year.toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Hora: '),
                              Text(
                                homeStore.data[index].data.hour < 10
                                    ? '0' +
                                        homeStore.data[index].data.hour
                                            .toString() +
                                        ':'
                                    : '' +
                                        homeStore.data[index].data.hour
                                            .toString() +
                                        ':',
                              ),
                              Text(
                                homeStore.data[index].data.minute < 10
                                    ? '0' +
                                        homeStore.data[index].data.minute
                                            .toString() +
                                        ':'
                                    : '' +
                                        homeStore.data[index].data.minute
                                            .toString() +
                                        ':',
                              ),
                              Text(
                                homeStore.data[index].data.second < 10
                                    ? '0' +
                                        homeStore.data[index].data.second
                                            .toString()
                                    : '' +
                                        homeStore.data[index].data.second
                                            .toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          '/glucose/details_glucose',
                          arguments: homeStore.data[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
