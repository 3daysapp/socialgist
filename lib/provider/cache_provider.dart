import 'package:socialgist/model/cache.dart';
import 'package:socialgist/util/config.dart';
import 'package:socialgist/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

///
///
///
class CacheProvider {
  final String table = 'local_cache';

  // TODO - Image cache. // method = 'IMAGE_CACHE' // response = path to image.
  // TODO - Clear cache.
  // TODO - Heuristic to remove old cache data.

  ///
  ///
  ///
  Future<Cache> hasCache(String method, String url) async {
    if (Config().isWeb) return null;

    Database db = await DbHelper().getDb();

    List<Map<String, dynamic>> rows = await db.query(
      table,
      where: 'method = ? AND url = ?',
      whereArgs: [method, url],
    );

    if (rows.length == 1) {
      return Cache.fromJson(rows.first);
    }

    if (rows.length > 1) {
      await db.delete(
        table,
        where: 'method = ? AND url = ?',
        whereArgs: [method, url],
      );
    }

    return null;
  }

  ///
  ///
  ///
  Future<int> saveOrUpdate(Cache cache) async {
    if (Config().isWeb) return null;

    Database db = await DbHelper().getDb();

    DateTime now = DateTime.now();

    if (cache.id == null) {
      cache.createdAt = now;
    }

    cache.updatedAt = now;

    return db.insert(
      table,
      cache.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
