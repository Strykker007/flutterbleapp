import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutterbleapp/app/modules/home/home_store.dart';

class DevicePage extends StatefulWidget {
  final String title;
  const DevicePage({Key? key, this.title = 'Parear Dispositivo'})
      : super(key: key);
  @override
  DevicePageState createState() => DevicePageState();
}

class DevicePageState extends State<DevicePage> {
  HomeStore store = Modular.get<HomeStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange[300],
        title: Text(
          'Parear Dispositivo',
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
            icon: Icon(Icons.arrow_forward_sharp),
          ),
          IconButton(
              onPressed: () {
                int decimalValue = 35;

                int binaryValue = 0;

                int i = 1;

                while (binaryValue.bitLength <= 8) {
                  binaryValue = binaryValue + (decimalValue % 2) * i;

                  decimalValue = (decimalValue / 2).floor();

                  i = i * 10;
                }
                String parse = binaryValue.toString();
                var list = parse.split('').reversed;
                print("the binary value is $list");
              },
              icon: Icon(Icons.add))
        ],
      ),
      // appBar: AppBar(
      //   title: Text('Parear dispositivos!!!'),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       store.convertData(store.response, store.glucoseContextList);
      //       Navigator.of(context).pushNamed(
      //         '/glucose',
      //       );
      //     },
      //     icon: Icon(Icons.arrow_forward_sharp),
      //   ),
      //   IconButton(
      //       onPressed: () {
      //         int decimalValue = 35;

      //         int binaryValue = 0;

      //         int i = 1;

      //         while (binaryValue.bitLength <= 8) {
      //           binaryValue = binaryValue + (decimalValue % 2) * i;

      //           decimalValue = (decimalValue / 2).floor();

      //           i = i * 10;
      //         }
      //         String parse = binaryValue.toString();
      //         var list = parse.split('').reversed;
      //         print("the binary value is $list");
      //       },
      //       icon: Icon(Icons.add))
      // ],
      // ),
      body: ScopedBuilder<HomeStore, Exception, BluetoothDeviceState>(
        store: store,
        onState: (_, connectionState) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, devices) => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // children: [
                    //   Container(
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey[300],
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Icon(Icons.bluetooth_searching),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           'meter+08417153',
                    //           style: TextStyle(fontSize: 15),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     height: 5,
                    //   ),
                    //   Container(
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey[300],
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Icon(Icons.bluetooth_searching),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           'meter+07462838',
                    //           style: TextStyle(fontSize: 15),
                    //         ),
                    //       ],
                    //     ),
                    //   )
                    // ],
                    children: devices.data!
                        .map(
                          (r) => r.device.name.length < 1
                              ? Container()
                              : ListTile(
                                  title: Text(r.device.name),
                                  onTap: () async {
                                    await store.connect(r.device);

                                    await store.obtainData(r.device).then(
                                      (value) {
                                        store.convertData(
                                          store.response,
                                          // store.glucoseContextList,
                                        );
                                        Navigator.pushNamed(
                                          context,
                                          '/glucose',
                                          arguments: r.device,
                                        );
                                      },
                                    );
                                  },
                                ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        },
        onError: (context, error) => Center(
          child: Text(
            'Nenhum dispositivo encontrado!!',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[300],
        onPressed: () {
          store.searchDevices();
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
