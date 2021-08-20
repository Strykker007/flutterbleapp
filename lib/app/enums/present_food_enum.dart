enum PresentFood {
  prePrandial,
  posPrandial,
  fasting,
  snack,
  bedTime,
  noContext
}

extension PresentFoodExtension on PresentFood {
  String get label {
    switch (this) {
      case PresentFood.prePrandial:
        return 'Pré-Prandial';
      case PresentFood.posPrandial:
        return 'Pós-Prandial';
      case PresentFood.fasting:
        return 'Jejum';
      case PresentFood.snack:
        return 'Casual';
      case PresentFood.bedTime:
        return 'Antes de dormir';
      case PresentFood.noContext:
        return 'Não informado';
      default:
        return 'Não informado';
    }
  }

  String get toJson {
    switch (this) {
      case PresentFood.prePrandial:
        return 'Pré-Prandial';
      case PresentFood.posPrandial:
        return 'Pós-Prandial';
      case PresentFood.fasting:
        return 'Jejum';
      case PresentFood.snack:
        return 'Casual';
      case PresentFood.bedTime:
        return 'Antes de dormir';
      case PresentFood.noContext:
        return 'Não informado';
      default:
        return 'Não informado';
    }
  }
}

PresentFood presentFoodFromInt(int presentFood) {
  switch (presentFood) {
    case 1:
      return PresentFood.prePrandial;
    case 2:
      return PresentFood.posPrandial;
    case 3:
      return PresentFood.fasting;
    case 4:
      return PresentFood.snack;
    case 5:
      return PresentFood.bedTime;
    case 0:
      return PresentFood.noContext;
    default:
      return PresentFood.noContext;
  }
}
