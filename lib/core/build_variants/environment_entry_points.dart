import 'package:nudge/core/config/app_config.dart';
import 'package:nudge/features/app/app_entry_point.dart';

class DevelopmentEntryPoint extends AppEntryPoint {
  DevelopmentEntryPoint() : super(AppConfiguration.development);
}

class ProductionEntryPoint extends AppEntryPoint {
  ProductionEntryPoint() : super(AppConfiguration.production);
}

class StagingEntryPoint extends AppEntryPoint {
  StagingEntryPoint() : super(AppConfiguration.staging);
}
