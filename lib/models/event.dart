class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String location;

  Event(this.title, this.description, this.date, this.time, this.location,
      [this.id]);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'desc': description,
        'date': date.toIso8601String(),
        'time': time,
        'location': location,
      };
}
