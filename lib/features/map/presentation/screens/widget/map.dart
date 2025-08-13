import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';

class MapWidget extends StatefulWidget {
  final VoidCallback? onMapTap;
  final List<Event> events;
  final void Function(int index)? onMarkerTap;

  const MapWidget({
    super.key,
    this.onMapTap,
    required this.events,
    this.onMarkerTap,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  static const LatLng _posInitial = LatLng(-27.9600, 153.3650);

  BitmapDescriptor? mapMarker;
  BitmapDescriptor? secondMapMarker;
  final Set<Marker> _markers = {};
  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _setCustomMarker();
  }

  void _addEventMarkers() {
    _markers.clear();
    for (int i = 0; i < widget.events.length; i++) {
      final event = widget.events[i];
      _markers.add(
        Marker(
          markerId: MarkerId('event-$i'),
          position: LatLng(event.latitude!, event.longitude!),
          icon: mapMarker ?? BitmapDescriptor.defaultMarker,
          onTap: () {
            widget.onMarkerTap?.call(i);
          },
        ),
      );
    }
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString(
      'assets/maptheme/map_style.json',
    );
    setState(() {
      _mapStyle = style;
    });
  }

  Future<void> _setCustomMarker() async {
    mapMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      Assets.images.purpleMarker.path,
      height: 16,
      width: 16,
    );

    secondMapMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      Assets.images.purpleMarker.path,
      height: 16,
      width: 16,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      buildingsEnabled: false,
      initialCameraPosition: const CameraPosition(
        target: _posInitial,
        zoom: 14,
      ),
      mapType: MapType.normal,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        controller.setMapStyle(_mapStyle);
        setState(() {
          _addEventMarkers();
        });
      },
      onTap: (_) {
        FocusScope.of(context).unfocus(); // Hide keyboard
        widget.onMapTap?.call(); // Trigger parent callback if any
      },
    );
  }
}
