import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_triple/flutter_triple.dart';

class GlucoseMeasurementStore extends NotifierStore<Exception, bool> {
  GlucoseMeasurementStore() : super(false);

  // Future<List<int>> obtainData(BluetoothDevice device) async {
  //   List<int> data;

  //   bool completeWrite = false;
  //   await device.discoverServices();

  //   print(device.state);
  //   device.services.forEach(
  //     (service) {
  //       service.forEach(
  //         (element) {
  //           element.characteristics.forEach(
  //             (characteristic) async {
  //               if (characteristic.uuid.toString().contains('2a18') &&
  //                   !characteristic.isNotifying) {
  //                 try {
  //                   log('Iniciando configuracão da caracteristica 2a18');
  //                   await characteristic.setNotifyValue(true);

  //                   log('Notificação configurada com sucesso!');
  //                 } catch (e) {
  //                   log('Erro ao configurar a notificação');
  //                 }
  //               }

  //               if (characteristic.uuid.toString().contains('2a34') &&
  //                   !characteristic.isNotifying) {
  //                 try {
  //                   log('Iniciando configuracão da caracteristica 2a34');
  //                   await characteristic.setNotifyValue(true);
  //                   log('Notificação configurada com sucesso!');
  //                 } catch (e) {
  //                   log('Erro ao configurar a notificação');
  //                 }
  //               }

  //               if (characteristic.uuid.toString().contains('2a18')) {
  //                 characteristic.value.listen(
  //                   (event) {
  //                     if (event.length > 0) {
  //                       // return event;
  //                     }
  //                   },
  //                 );
  //               }
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );

  //   device.services.forEach(
  //     (service) {
  //       service.forEach(
  //         (element) {
  //           if (element.uuid.toString().contains('1808')) {
  //             element.characteristics.forEach(
  //               (characteristic) async {
  //                 if (characteristic.uuid.toString().contains('2a52') &&
  //                     !characteristic.isNotifying &&
  //                     !completeWrite) {
  //                   try {
  //                     log('Iniciando configuracão do RACP');
  //                     await characteristic.setNotifyValue(true);
  //                     log('Notificação configurada com sucesso!');
  //                   } catch (e) {
  //                     log('Erro ao configurar a notificação');
  //                   }

  //                   try {
  //                     log('Finalizando configuracão do RACP');
  //                     await characteristic.write([1, 1]);
  //                     completeWrite = true;
  //                     log('Escrita configurada com sucesso!');
  //                   } catch (e) {
  //                     log('Erro ao realizar escrita ao RACP');
  //                   }
  //                 }
  //                 if (characteristic.uuid.toString().contains('2a52') &&
  //                     characteristic.isNotifying &&
  //                     !completeWrite) {
  //                   try {
  //                     log('Obtendo dados...');
  //                     await characteristic.write([1, 1]);
  //                     completeWrite = true;
  //                     log('Dados solicitados com sucesso!');
  //                   } catch (e) {
  //                     log('Erro ao obter os dados do dispositivo!');
  //                   }
  //                 }
  //               },
  //             );
  //           }
  //         },
  //       );
  //     },
  //   );

  //   // completeWrite = false;
  //   // print(response);

  //   return data;
  // }
}
