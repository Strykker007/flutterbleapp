enum PresentCarbohidrate {
  breakfast,
  lunch,
  dinner,
  snack,
  drink,
  supper,
  brunch,
  noContext
}

extension presentCarbohidrateExtension on PresentCarbohidrate {
  String get label {
    switch (this) {
      case PresentCarbohidrate.breakfast:
        return 'Café da Manhã';
      case PresentCarbohidrate.lunch:
        return 'Almoço';
      case PresentCarbohidrate.dinner:
        return 'Jantar';
      case PresentCarbohidrate.snack:
        return 'Lanche';
      case PresentCarbohidrate.drink:
        return 'Bebida';
      case PresentCarbohidrate.supper:
        return 'Ceia';
      case PresentCarbohidrate.brunch:
        return 'Brunch';
      case PresentCarbohidrate.noContext:
        return 'Não informado';
      default:
        return 'Não informado';
    }
  }

  String get toJson {
    switch (this) {
      case PresentCarbohidrate.breakfast:
        return 'Café da Manhã';
      case PresentCarbohidrate.lunch:
        return 'Almoço';
      case PresentCarbohidrate.dinner:
        return 'Jantar';
      case PresentCarbohidrate.snack:
        return 'Lanche';
      case PresentCarbohidrate.drink:
        return 'Bebida';
      case PresentCarbohidrate.supper:
        return 'Ceia';
      case PresentCarbohidrate.brunch:
        return 'Brunch';
      case PresentCarbohidrate.noContext:
        return 'Não informado';
      default:
        return 'Não informado';
    }
  }
}

PresentCarbohidrate presentCarbohidrateFromInt(int presentCarbohidrate) {
  switch (presentCarbohidrate) {
    case 1:
      return PresentCarbohidrate.breakfast;
    case 2:
      return PresentCarbohidrate.lunch;
    case 3:
      return PresentCarbohidrate.dinner;
    case 4:
      return PresentCarbohidrate.snack;
    case 5:
      return PresentCarbohidrate.drink;
    case 6:
      return PresentCarbohidrate.supper;
    case 7:
      return PresentCarbohidrate.brunch;
    case 0:
      return PresentCarbohidrate.noContext;
    default:
      return PresentCarbohidrate.noContext;
  }
}
