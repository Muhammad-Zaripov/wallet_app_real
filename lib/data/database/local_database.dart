import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_app/models/wallet_model.dart';

class LocalDatabase {
  final String _tableName = 'wallet';
  LocalDatabase._singleton();
  static final _private = LocalDatabase._singleton();
  factory LocalDatabase() {
    return _private;
  }
  Database? _database;

  Future<void> init() async {
    _database ??= await _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final detabasePath = await getApplicationDocumentsDirectory();
    final path = '${detabasePath.path}/$_tableName.db';
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
    create table $_tableName(
      id integer primary key autoincrement,
      title text not null,
      amount integer not null,
      date text not null)''');
  }

  Future<int> addCosts(WalletModel cost) async {
    final db = await database;
    return await db.insert(_tableName, cost.toMap());
  }

  Future<List<WalletModel>> getCosts() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((m) => WalletModel.fromMap(m)).toList();
  }

  Future<int> updateCost(WalletModel cost) async {
    final db = await database;
    return await db.update(
      _tableName,
      cost.toMap(),
      where: 'id = ?',
      whereArgs: [cost.id],
    );
  }

  Future<int> deleteCost(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    _database?.close();
  }
}
