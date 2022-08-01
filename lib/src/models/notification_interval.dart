class NotificationInterval {
  final String title;
  final int interval;

  const NotificationInterval({
    required this.title,
    required this.interval,
  });

  // from map
  factory NotificationInterval.fromMap(Map map) {
    return NotificationInterval(
      title: map['title'] as String,
      interval: map['interval'] as int,
    );
  }

  // to map
  Map toMap() {
    return {
      'title': title,
      'interval': interval,
    };
  }

  @override
  String toString() {
    return 'NotificationInterval{title: $title, interval: $interval}';
  }
}
