import 'package:socialgist/model/AbstractModel.dart';

///
/// https://developer.github.com/v3/#conditional-requests
///
/// ETag: "644b5b0155e6404a9cc4bd9d8b1ae730" => If-None-Match
/// Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT => If-Modified-Since
///
class Cache extends AbstractModel<Cache> {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String method;
  String url;
  String etag;
  String lastModified;
  String response;
  int hit;

  ///
  ///
  ///
  Cache({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.method,
    this.url,
    this.etag,
    this.lastModified,
    this.response,
    this.hit,
  });

  ///
  ///
  ///
  Cache.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['created_at'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['created_at']),
        updatedAt = json['updated_at'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['updated_at']),
        method = json['method'],
        url = json['url'],
        etag = json['etag'],
        lastModified = json['last_modified'],
        response = json['response'],
        hit = json['hit'] ?? 0;

  ///
  ///
  ///
  @override
  Cache fromJson(Map<String, dynamic> json) {
    return Cache.fromJson(json);
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (createdAt != null) {
      json['created_at'] = createdAt.millisecondsSinceEpoch;
    }
    if (updatedAt != null) {
      json['updated_at'] = updatedAt.millisecondsSinceEpoch;
    }
    if (method != null) json['method'] = method;
    if (url != null) json['url'] = url;
    if (etag != null) json['etag'] = etag;
    if (lastModified != null) json['last_modified'] = lastModified;
    if (response != null) json['response'] = response;
    json['hit'] = hit ?? 0;
    return json;
  }

  ///
  ///
  ///
  @override
  String toString() {
    return '$method - $url: $hit';
  }
}
