class Event {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;

  Event(this.title, this.description, this.date, this.time, this.location,
      [this.id]);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'desc': description,
        'date': date,
        'time': time,
        'location': location,
      };
}
