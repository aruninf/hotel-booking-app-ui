import 'package:get/get.dart';
import 'package:nudge/features/places/data/source/places_remote_source.dart';

class PlacesController extends GetxController {
  PlacesController({required this.remoteSource});

  final PlacesRemoteSource remoteSource;
}
