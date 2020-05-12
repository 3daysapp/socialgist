import 'package:socialgist/model/AbstractModel.dart';
import 'package:socialgist/model/User.dart';

///
/// https://developer.github.com/v3/gists/comments/
///
class GistComment extends AbstractModel<GistComment> {
  int id;
  String nodeId;
  String url;
  String body;
  User user;
  String createdAt;
  String updatedAt;

  ///
  ///
  ///
  GistComment({
    this.id,
    this.nodeId,
    this.url,
    this.body,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  ///
  ///
  ///
  GistComment.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    nodeId = json['node_id'];
    url = json['url'];
    body = json['body'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['url'] = url;
    data['body'] = body;
    if (user != null) data['user'] = user;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  ///
  ///
  ///
  DateTime get updatedAtDate => DateTime.parse(updatedAt);

  ///
  ///
  ///
  @override
  GistComment fromJson(Map<String, dynamic> json) {
    return GistComment.fromJson(json);
  }
}
