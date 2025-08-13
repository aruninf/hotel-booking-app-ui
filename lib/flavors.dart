enum Flavor { prod, di, api }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'Nudge';
      case Flavor.di:
        return 'Nudge DI';
      case Flavor.api:
        return 'Nudge API';
    }
  }
}
