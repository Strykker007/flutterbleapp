import 'dart:convert';

import 'package:flutterbleapp/app/enums/present_carbohidrate_enum.dart';
import 'package:flutterbleapp/app/enums/present_food_enum.dart';

class GlucoseModel {
  late int measurement;
  late DateTime data;
  late int id;
  // GlucoseContext? glucoseContext;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'glucose': measurement,
      'data': data,
    };
  }

  GlucoseModel.fromListInt({required List<int> glucose}) {
    id = glucose[1];
    measurement = glucose[12];
    data = _extractDate(glucose);
    // glucoseContext = GlucoseContext?.fromListInt(context);
  }

  DateTime _extractDate(List<int> glucose) {
    int year = (glucose[3] + (glucose[4] << 8));
    int month = glucose[5];
    int day = glucose[6];
    int hour = glucose[7];
    int minutes = glucose[8];
    int seconds = glucose[9];
    int offset = glucose[10] + (glucose[11] << 8);

    if (offset >= 32769 && offset <= 65535) {
      DateTime date = DateTime(year, month, day, hour, minutes, seconds)
          .subtract(Duration(minutes: (65535 - offset)));
      return date;
    } else {
      DateTime date = DateTime(year, month, day, hour, minutes, seconds)
          .add(Duration(minutes: offset));
      return date;
    }
  }

  String toJson() => json.encode(toMap());
}

class GlucoseContext {
  late String presentCarbohidrate;
  late String presentFood;
  late String testerHealth = '';
  late String presentExercise = '';
  late String medicationId = '';
  late String medicationValue = '';
  late String presentHba1c = '';

  GlucoseContext({
    this.presentCarbohidrate = '',
    this.presentFood = '',
    this.testerHealth = '',
    this.presentExercise = '',
    this.medicationId = '',
    this.medicationValue = '',
    this.presentHba1c = '',
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  GlucoseContext.fromListInt(List<int> context) {
    presentCarbohidrate = getFlag(context[0], 0) == 1
        ? presentCarbohidrateFromInt(context[3]).toJson
        : presentCarbohidrateFromInt(0).toJson;
    presentFood = getFlag(context[0], 1) == 1
        ? presentFoodFromInt(context[3]).toJson
        : presentFoodFromInt(0).toJson;
  }

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

    return int.parse(teste[index]);
  }
}
