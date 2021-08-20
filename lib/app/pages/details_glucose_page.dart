import 'package:flutter/material.dart';
import 'package:flutterbleapp/app/models/glucose_model.dart';

class DetailsGlucosePage extends StatefulWidget {
  final GlucoseModel glucose;
  const DetailsGlucosePage({Key? key, required this.glucose}) : super(key: key);
  @override
  DetailsGlucosePageState createState() => DetailsGlucosePageState();
}

class DetailsGlucosePageState extends State<DetailsGlucosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Detalhes da medição',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                'Glicemia',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[600],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 30),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  gradient: RadialGradient(
                    colors: [Colors.orange, Colors.orangeAccent, Colors.white],
                    center: Alignment.center,
                  ),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.glucose.measurement.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'mg/dL',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[700],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconTheme(
                          data: IconThemeData(opacity: 0.7),
                          child: Icon(
                            Icons.bloodtype,
                            size: 70,
                            color: Colors.red,
                          ),
                        ),
                        Text('Realizado em:'),
                        Container(
                          margin: EdgeInsets.only(left: 82),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined),
                                  Text(widget.glucose.data.day < 10
                                      ? '0' +
                                          widget.glucose.data.day.toString() +
                                          '/'
                                      : '' +
                                          widget.glucose.data.day.toString() +
                                          '/'),
                                  Text(widget.glucose.data.month < 10
                                      ? '0' +
                                          widget.glucose.data.month.toString()
                                      : '' +
                                          widget.glucose.data.month.toString()),
                                  Text(
                                    '/' + widget.glucose.data.year.toString(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.watch_later),
                                  Text(
                                    widget.glucose.data.hour < 10
                                        ? '0' +
                                            widget.glucose.data.hour
                                                .toString() +
                                            ':'
                                        : '' +
                                            widget.glucose.data.hour
                                                .toString() +
                                            ':',
                                  ),
                                  Text(
                                    widget.glucose.data.minute < 10
                                        ? '0' +
                                            widget.glucose.data.minute
                                                .toString() +
                                            ':'
                                        : '' +
                                            widget.glucose.data.minute
                                                .toString() +
                                            ':',
                                  ),
                                  Text(
                                    widget.glucose.data.second < 10
                                        ? '0' +
                                            widget.glucose.data.second
                                                .toString()
                                        : '' +
                                            widget.glucose.data.second
                                                .toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contexto:'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Refeição: ' +
                              widget.glucose.glucoseContext!.presentFood),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Carboidrato presente: ' +
                              widget
                                  .glucose.glucoseContext!.presentCarbohidrate),
                        ],
                      ),
                    )
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
