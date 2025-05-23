import 'package:eventcountdown/models/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static Database? database;

  static getDatabase() async {
    if (database == null) {
      database = await initialDatabase();
      return database;
    } else {
      return database;
    }
  }

  static initialDatabase() async {
    String path = join(await getDatabasesPath(), 'eventcountdown.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        Batch batch = db.batch();
        batch.execute('''
        CREATE TABLE events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        desc TEXT,
        time TEXT,
        date TEXT,
        location TEXT
        )
        ''');
        batch.commit();
      },
    );
  }

  Future addEvent(Event newEvent) async {
    Database db = await getDatabase();
    db.insert(
      'events',
      newEvent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateEvent(Event event) async {
    Database db = await getDatabase();
    await db.update('events', event.toMap(),
        where: 'id = ?', whereArgs: [event.id]);
  }

  Future<List<Event>> getEvents() async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('events');

    return maps.map((item) {
      return Event(
        item['title'],
        item['desc'],
        item['date'],
        item['time'],
        item['location'],
        item['id'],
      );
    }).toList();
  }

  Future deleteEvent(int id) async {
    Database db = await getDatabase();
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}
