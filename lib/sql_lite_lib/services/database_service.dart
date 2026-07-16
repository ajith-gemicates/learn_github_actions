import 'package:learn_github_actions/sql_lite_lib/model/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? db;

  DatabaseService();

  static const tableName = 'task_table';
  static const tableId = 'id';
  static const taskTableTaskName = 'taskName';
  static const taskTableTaskDone = 'taskDone';
  static const taskTableCreatedAt = 'createdAt';
  static const taskTableUpdatedAt = 'UpdatedAt';

  Future<Database> get database async {
    db ??= await getDataBase();
    return db!;
  }

  Future<Database> getDataBase() async {
    final dbPath = await getDatabasesPath();
    final dbPathName = join(dbPath, 'sqlflite_demo.db');
    final database = await openDatabase(
      dbPathName,
      version: 2, // bumped from 1
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE $tableName (
        $tableId INTEGER PRIMARY KEY AUTOINCREMENT,
        $taskTableTaskName TEXT NOT NULL,
        $taskTableTaskDone INTEGER NOT NULL,
        $taskTableCreatedAt TEXT NOT NULL,
        $taskTableUpdatedAt TEXT
      )
    ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE $tableName ADD COLUMN $taskTableCreatedAt TEXT',
          );
          await db.execute(
            'ALTER TABLE $tableName ADD COLUMN $taskTableUpdatedAt TEXT',
          );
        }
      },
    );
    return database;
  }

  Future<int> addTask(String taskName) async {
    final db = await database;
    int response = await db.insert(tableName, {
      taskTableTaskName: taskName,
      taskTableTaskDone: 0,
      taskTableCreatedAt: DateTime.now().toString(),
    });
    return response;
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final tasks = await db.query(tableName);
    List<TaskModel> data = tasks
        .map(
          (e) => TaskModel(
            id: e['id'] as int,
            taskName: e['taskName'] as String,
            taskDone: e['taskDone'] as int,
            createdAt: e['createdAt'] as String?,
            updatedAt: e['updatedAt'] as String?,
          ),
        )
        .toList();
    return data;
  }

  Future<int> updateTask(TaskModel taskModel) async {
    final db = await database;
    return await db.update(
      tableName,
      taskModel.toMap(),
      where: '$tableId = ?',
      whereArgs: [taskModel.id],
    );
  }
}
