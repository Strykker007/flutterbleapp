import 'package:flutterbleapp/app//modules/glucose_measurement/glucoseMeasurement_Page.dart';
import 'package:flutterbleapp/app//modules/glucose_measurement/glucoseMeasurement_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterbleapp/app/pages/details_glucose_page.dart';

class GlucoseMeasurementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => GlucoseMeasurementStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/glucose',
        child: (_, args) => GlucoseMeasurementPage(device: args.data)),
    ChildRoute('/details_glucose',
        child: (_, args) => DetailsGlucosePage(glucose: args.data))
  ];
}
