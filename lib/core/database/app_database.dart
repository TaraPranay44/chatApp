// core/database/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

// Define tables
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  IntColumn get senderId => integer().references(Users, #id)();
  IntColumn get receiverId => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Users, Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
  
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
  
  // User queries
  Future<List<User>> getAllUsers() => select(users).get();
  Future<User?> getUserById(int id) => 
    (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);
  Future<bool> updateUser(User user) => update(users).replace(user);
  Future<int> deleteUser(int id) => 
    (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  
  // Message queries
  Future<List<Message>> getMessages(int userId1, int userId2) {
    return (select(messages)
      ..where((tbl) => 
        (tbl.senderId.equals(userId1) & tbl.receiverId.equals(userId2)) |
        (tbl.senderId.equals(userId2) & tbl.receiverId.equals(userId1)))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)])).get();
  }
  
  Future<int> insertMessage(MessagesCompanion message) => 
    into(messages).insert(message);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.db'));
    return NativeDatabase(file);
  });
}
