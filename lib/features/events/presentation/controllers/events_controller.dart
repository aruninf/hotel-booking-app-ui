import 'package:get/get.dart';
import 'package:nudge/features/events/data/source/events_remote_source.dart';

class EventsController extends GetxController {
  EventsController({required this.remoteSource});

  final EventsRemoteSource remoteSource;
}
