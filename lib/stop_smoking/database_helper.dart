import 'package:sqflite/sqflite.dart';
import 'package:guidohinrichs/stop_smoking/smoking_data.dart';

class DatabaseHelper {
  static const _databaseName = "SmokingData.db";
  static const _databaseVersion = 1;

  // Tabellen für Rauchgewohnheiten
  static const tableSmokingData = 'smoking_data';
  static const columnId = '_id';
  static const columnSelectedCigarettes = 'selectedCigarettes';
  static const columnFirstCigaretteTime = 'firstCigaretteTime';
  static const columnLastCigaretteTime = 'lastCigaretteTime';
  static const columnMorningCigarettes = 'morningCigarettes';
  static const columnAfternoonCigarettes = 'afternoonCigarettes';
  static const columnEveningCigarettes = 'eveningCigarettes';

  // Tabelle für Fortschrittsdaten
  static const tableProgress = 'progress';
  static const columnDate = 'date';
  static const columnCigarettesRemaining = 'cigarettes_remaining';
  static const columnMethod = 'method';

  // Singleton pattern zur Vermeidung mehrerer Instanzen des DatabaseHelper
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Zugriff auf Datenbank
  Future<Database> get database async {
    if (_database != null) return _database!; // Rückgabe der Datenbankinstanz
    _database =
        await _initDatabase(); // Initialisierung der DB, wenn nicht vorhanden
    return _database!;
  }

  _initDatabase() async {
    String path = await getDatabasesPath(); // Pfad zum Verzeichnis
    return await openDatabase(
      '$path/$_databaseName', // Pfad zur Datenbankdatei
      version: _databaseVersion, // Version der Datenbank
      onCreate: _onCreate, // Tabellen erstellen
    );
  }

  // Erstellen der Tabellen
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableSmokingData (
        $columnId INTEGER PRIMARY KEY,
        $columnSelectedCigarettes INTEGER NOT NULL,
        $columnFirstCigaretteTime TEXT NOT NULL,
        $columnLastCigaretteTime TEXT NOT NULL,
        $columnMorningCigarettes INTEGER NOT NULL,
        $columnAfternoonCigarettes INTEGER NOT NULL,
        $columnEveningCigarettes INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableProgress (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnDate TEXT NOT NULL,
        $columnCigarettesRemaining INTEGER NOT NULL,
        $columnMethod TEXT NOT NULL
      )
    ''');
  }

  // Einfügen oder Aktualisieren von Rauchgewohnheiten
  Future<int> upsertSmokingData(SmokingData smokingData) async {
    Database db = await instance.database;

    // Überprüfen ob bereits ein Datensatz existiert
    List<Map<String, dynamic>> existingData = await db.query(tableSmokingData);

    if (existingData.isNotEmpty) {
      // Aktualisieren des bestehenden Datensatzes
      return await db.update(
        tableSmokingData,
        smokingData.toMap(),
        where: '$columnId = ?',
        whereArgs: [existingData.first[columnId]],
      );
    } else {
      // Fügt einen neuen Datensatz ein
      return await db.insert(tableSmokingData, smokingData.toMap());
    }
  }

  // Abrufen der Rauchgewohnheiten
  Future<SmokingData?> getSmokingData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableSmokingData);

    if (maps.isNotEmpty) {
      return SmokingData.fromMap(maps.first); // Rückgabe erster Datensatz
    }
    return null;
  }

  // Abrufen der Fortschrittsdaten
  Future<List<Map<String, dynamic>>> getProgressData() async {
    Database db = await instance.database;
    return await db.query(tableProgress, orderBy: '$columnDate ASC');
  }

  // Einfügen von Fortschrittsdaten
  Future<int> insertProgressData(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert(tableProgress, data);
  }
}
