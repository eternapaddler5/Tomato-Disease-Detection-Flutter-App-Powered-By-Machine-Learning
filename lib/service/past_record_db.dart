import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tomotoe_disease_detection_app/model/past_record.dart';

class PastRecordDatabase {
  PastRecordDatabase._();

  static final PastRecordDatabase instance = PastRecordDatabase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'past_records.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await _createTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS past_records');
          await _createTable(db);
        }
      },
    );
  }

  Future<void> _createTable(Database db) async {
    await db.execute('''
      CREATE TABLE past_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image_path TEXT NOT NULL,
        diagnosis_label TEXT NOT NULL,
        confidence REAL NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  Future<List<PastRecord>> fetchRecords() async {
    final db = await database;
    final maps = await db.query(
      'past_records',
      orderBy: 'created_at DESC',
    );
    return maps.map(PastRecord.fromMap).toList();
  }

  Future<PastRecord> insertRecord(PastRecord record) async {
    final db = await database;
    final id = await db.insert('past_records', record.toMap());
    return record.copyWith(id: id);
  }

  Future<void> deleteRecord(int id) async {
    final db = await database;
    await db.delete('past_records', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllRecords() async {
    final db = await database;
    await db.delete('past_records');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}

