class Event {
  final String date;
  final String time;
  final String title;
  final String location;
  final String imagePath;
  final double? latitude;
  final double? longitude;

  Event({
    required this.date,
    required this.time,
    required this.title,
    required this.location,
    required this.imagePath,
    this.latitude,
    this.longitude,
  });
}

class Connection {
  final String id;
  final String name;
  final String imagePath;
  final String location;
  final double? latitude;
  final double? longitude;

  Connection({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.location,
    this.latitude,
    this.longitude,
  });
}
