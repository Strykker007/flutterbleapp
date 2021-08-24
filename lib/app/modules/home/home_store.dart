import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutterbleapp/app/models/glucose_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomeStore extends NotifierStore<Exception, BluetoothDeviceState> {
  List<List<int>> response = [
    [27, 22, 0, 228, 7, 1, 27, 13, 20, 19, 156, 95, 103, 176, 248, 0, 8],
    [27, 23, 0, 228, 7, 2, 26, 12, 43, 33, 242, 255, 108, 176, 248, 0, 8],
    [27, 24, 0, 228, 7, 7, 14, 16, 2, 35, 86, 5, 146, 176, 248, 0, 0],
    [11, 25, 0, 229, 7, 4, 29, 14, 44, 38, 0, 0, 93, 176, 248, 0, 8],
    [27, 26, 0, 229, 7, 4, 29, 16, 28, 54, 121, 66, 111, 176, 248, 0, 8],
  ];
  List<List<int>> glucoseContextList = [
    [2, 22, 0, 1],
    [2, 23, 0, 2],
    [2, 24, 0, 2],
    [2, 26, 0, 1],
    [2, 25, 0, 1]
  ];

  // List<List<int>> response = []; //resposta da medida de glicose
  // List<List<int>> glucoseContextList = [];
  List<GlucoseModel> data = [];

  HomeStore() : super(BluetoothDeviceState.disconnected);

  int getFlag(int value, int index) {
    int decimalValue = value;

    int binaryValue = 0;

    int i = 1;

    while (decimalValue > 0) {
      binaryValue = binaryValue + (decimalValue % 2) * i;

      decimalValue = (decimalValue / 2).floor();

      i = i * 10;
    }
    String parse = binaryValue.toString();
    Iterable<String> list = parse.split('').reversed;
    List<String> teste = list.toList();

    return teste.length > 4 ? int.parse(teste[index]) : 0;
  }

  Future<void> receiveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? listPairedDevicesId = prefs.getStringList('id');

    FlutterBlue flutterBlue = FlutterBlue.instance;

    await flutterBlue.startScan(
      timeout: Duration(seconds: 2),
      // withServices: [Guid('00001808-0000-1000-8000-00805f9b34fb')],
    );

    await Future.delayed(Duration(seconds: 2))
        .then((_) => FlutterBlue.instance.stopScan());

    String id = '';

    flutterBlue.scanResults.forEach(
      (element) {
        element.forEach(
          (element) async {
            id = listPairedDevicesId!
                .firstWhere((id) => element.device.id.toString() == id);
            if (id.length > 0) {
              await connect(element.device).then(
                (_) async => await obtainData(element.device),
              );
            }
          },
        );
      },
    );
  }

  void convertData(
    List<List<int>> response,
    // List<List<int>> glucoseContextList,
  ) {
    // List<int> glucoseContext = [];
    if (data.length != response.length) {
      response.forEach(
        (element) async {
          // if (getFlag(element[0], 4) == 1) {
          //   glucoseContext = glucoseContextList
          //       .firstWhere((context) => element[1] == context[1]);
          // }

          data.add(GlucoseModel.fromListInt(
            glucose: element,
            // context: glucoseContext,
          ));

          // glucoseContext = [];
        },
      );
    }
  }

  Future<void> searchDevices() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    await flutterBlue
        .startScan(
            // withServices: [Guid('00001808-0000-1000-8000-00805f9b34fb')],
            )
        .timeout(
          Duration(seconds: 10),
        )
        .catchError(
      (onError) {
        flutterBlue.stopScan();
      },
    ).then(
      (value) => flutterBlue.stopScan(),
    );
  }

  // Future<void> testLoading() async {
  //   setLoading(true);

  //   await Future.delayed(Duration(seconds: 5));

  //   setLoading(false);
  //   update(BluetoothDeviceState.connecting);
  // }

  Future<void> connect(BluetoothDevice device) async {
    // setLoading(true);

    update(BluetoothDeviceState.connecting);

    await device.connect(autoConnect: true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? listPairedDevicesId = prefs.getStringList('id');

    try {
      if (listPairedDevicesId!.isEmpty) {
        listPairedDevicesId.add(device.id.toString());
        await prefs.setStringList('id', listPairedDevicesId);
      } else {
        String id = listPairedDevicesId.firstWhere(
          (element) => element.contains(
            device.id.toString(),
          ),
        );

        if (id.length <= 0) {
          await prefs.setStringList('id', listPairedDevicesId);
        }
      }
    } catch (e) {
      listPairedDevicesId!.add(device.id.toString());
      await prefs.setStringList('id', listPairedDevicesId);
    }

    // setLoading(false);
  }

  Future<void> obtainData(BluetoothDevice device) async {
    setLoading(true);
    await device.discoverServices();

    await _setConfigs(device).then(
      (value) async {
        await Future.delayed(Duration(seconds: 3)).then(
          (value) {
            log('Download realizado com sucesso');
          },
        );
      },
    );

    setLoading(false);
    update(BluetoothDeviceState.disconnected);
  }

  Future<void> _setConfigs(BluetoothDevice device) async {
    BluetoothCharacteristic glucoseMeasurement;
    BluetoothCharacteristic glucoseContext;
    BluetoothCharacteristic racp;
    BluetoothService glucoseService;

    device.services.forEach(
      (services) async {
        glucoseService = services
            .firstWhere((service) => service.uuid.toString().contains('1808'));
        glucoseMeasurement = glucoseService.characteristics
            .firstWhere((element) => element.uuid.toString().contains('2a18'));
        racp = glucoseService.characteristics
            .firstWhere((element) => element.uuid.toString().contains('2a52'));

        try {
          log('Iniciando configuracão da caracteristica 2a18');
          await glucoseMeasurement.setNotifyValue(true);
          glucoseMeasurement.value.listen(
            (value) {
              if (response.every((element) => element[1] != value[1])) {
                response.add(value);
              }
              log('Evento ouvindo caracteristica');
            },
          );
          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
        try {
          log('Iniciando configuracão da caracteristica 2a52');
          await racp.setNotifyValue(true);
          await racp.write([1, 3, 2, 24, 0]);

          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
        glucoseContext = glucoseService.characteristics
            .firstWhere((element) => element.uuid.toString().contains('2a34'));
        try {
          log('Iniciando configuracão da caracteristica 2a34');
          await glucoseContext.setNotifyValue(true);
          glucoseContext.value.listen(
            (value) {
              if (glucoseContextList
                  .every((element) => element[1] != value[1])) {
                glucoseContextList.add(value);
              }
              log('Evento ouvindo caracteristica');
            },
          );
          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
        // notificando o RACP
      },
    );
  }
}
