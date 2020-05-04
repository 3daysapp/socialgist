import 'AbstractModel.dart';
import 'User.dart';

///
///
///
class Gist extends AbstractModel<Gist> {
  String url;
  String forksUrl;
  String commitsUrl;
  String id;
  String nodeId;
  String gitPullUrl;
  String gitPushUrl;
  String htmlUrl;
  List<File> files;
  bool public;
  String createdAt;
  String updatedAt;
  String description;
  int comments;
  String commentsUrl;
  User owner;
  bool truncated;

  Gist({
    this.url,
    this.forksUrl,
    this.commitsUrl,
    this.id,
    this.nodeId,
    this.gitPullUrl,
    this.gitPushUrl,
    this.htmlUrl,
    this.files,
    this.public,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.comments = 0,
    this.commentsUrl,
    this.owner,
    this.truncated,
  });

  ///
  ///
  ///
  Gist.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    forksUrl = json['forks_url'];
    commitsUrl = json['commits_url'];
    id = json['id'];
    nodeId = json['node_id'];
    gitPullUrl = json['git_pull_url'];
    gitPushUrl = json['git_push_url'];
    htmlUrl = json['html_url'];
    files = json['files'] != null
        ? (json['files'] as Map)
            .values
            .map((value) => File.fromJson(value))
            .toList()
        : null;
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    comments = json['comments'] ?? 0;
    commentsUrl = json['comments_url'];
    owner = json['owner'] != null ? User.fromJson(json['owner']) : null;
    truncated = json['truncated'];
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['forks_url'] = forksUrl;
    data['commits_url'] = commitsUrl;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['git_pull_url'] = gitPullUrl;
    data['git_push_url'] = gitPushUrl;
    data['html_url'] = htmlUrl;
    if (files != null) {
      data['files'] = {for (File file in files) file.filename: file.toJson()};
    }
    data['public'] = public;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['description'] = description;
    data['comments'] = comments;
    data['comments_url'] = commentsUrl;
    if (owner != null) {
      data['owner'] = owner.toJson();
    }
    data['truncated'] = truncated;
    return data;
  }

  DateTime get createdAtDate => DateTime.parse(createdAt);

  ///
  ///
  ///
  @override
  Gist fromJson(Map<String, dynamic> json) {
    return Gist.fromJson(json);
  }
}

///
///
///
class File {
  String filename;
  String type;
  String language;
  String rawUrl;
  int size;
  bool truncated;
  String content;

  ///
  ///
  ///
  File({
    this.filename,
    this.type,
    this.language,
    this.rawUrl,
    this.size,
    this.truncated,
    this.content,
  });

  ///
  ///
  ///
  File.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    type = json['type'];
    language = json['language'];
    rawUrl = json['raw_url'];
    size = json['size'];
    truncated = json['truncated'];
    content = json['content'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['filename'] = filename;
    data['type'] = type;
    data['language'] = language;
    data['raw_url'] = rawUrl;
    data['size'] = size;
    data['truncated'] = truncated;
    data['content'] = content;
    return data;
  }
}
