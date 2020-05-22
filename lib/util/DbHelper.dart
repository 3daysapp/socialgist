import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

///
///
///
class DbHelper {
  Database _db;
  final _lock = Lock();

  ///
  ///
  ///
  Future<Database> getDb() async {
    if (_db == null) {
      String databasesPath = await getDatabasesPath();

      String path = join(databasesPath, 'socialgist.db');

      if (!await Directory(dirname(path)).exists()) {
        await Directory(dirname(path)).create(recursive: true);
      }

      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            Batch batch = db.batch();

            batch.execute('CREATE TABLE IF NOT EXISTS local_cache ('
                '"id" INTEGER PRIMARY KEY NOT NULL,'
                '"created_at" INTEGER NOT NULL,'
                '"updated_at" INTEGER NOT NULL,'
                '"method" TEXT NOT NULL,'
                '"url" TEXT NOT NULL,'
                '"etag" TEXT,'
                '"last_modified" TEXT,'
                '"response" TEXT,'
                '"hit" INTEGER DEFAULT 0);');

            await batch.commit();
          },
        );
      });
    }

    return _db;
  }
}
