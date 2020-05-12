import 'AbstractModel.dart';

///
/// https://developer.github.com/v3/users/
///
class User extends AbstractModel<User> {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;
  String name;
  String company;
  String blog;
  String location;
  String email;
  bool hireable;
  String bio;
  int publicRepos;
  int publicGists;
  int followers;
  int following;
  String createdAt;
  String updatedAt;
  int privateGists;
  int totalPrivateRepos;
  int ownedPrivateRepos;
  int diskUsage;
  int collaborators;
  bool twoFactorAuthentication;
  Plan plan;

  ///
  ///
  ///
  User({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
    this.privateGists,
    this.totalPrivateRepos,
    this.ownedPrivateRepos,
    this.diskUsage,
    this.collaborators,
    this.twoFactorAuthentication,
    this.plan,
  }) : super();

  ///
  ///
  ///
  User.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
    name = json['name'];
    company = json['company'];
    blog = json['blog'];
    location = json['location'];
    email = json['email'];
    hireable = json['hireable'];
    bio = json['bio'];
    publicRepos = json['public_repos'];
    publicGists = json['public_gists'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    privateGists = json['private_gists'];
    totalPrivateRepos = json['total_private_repos'];
    ownedPrivateRepos = json['owned_private_repos'];
    diskUsage = json['disk_usage'];
    collaborators = json['collaborators'];
    twoFactorAuthentication = json['two_factor_authentication'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['followers_url'] = followersUrl;
    data['following_url'] = followingUrl;
    data['gists_url'] = gistsUrl;
    data['starred_url'] = starredUrl;
    data['subscriptions_url'] = subscriptionsUrl;
    data['organizations_url'] = organizationsUrl;
    data['repos_url'] = reposUrl;
    data['events_url'] = eventsUrl;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    data['site_admin'] = siteAdmin;
    data['name'] = name;
    data['company'] = company;
    data['blog'] = blog;
    data['location'] = location;
    data['email'] = email;
    data['hireable'] = hireable;
    data['bio'] = bio;
    data['public_repos'] = publicRepos;
    data['public_gists'] = publicGists;
    data['followers'] = followers;
    data['following'] = following;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['private_gists'] = privateGists;
    data['total_private_repos'] = totalPrivateRepos;
    data['owned_private_repos'] = ownedPrivateRepos;
    data['disk_usage'] = diskUsage;
    data['collaborators'] = collaborators;
    data['two_factor_authentication'] = twoFactorAuthentication;
    if (plan != null) {
      data['plan'] = plan.toJson();
    }
    return data;
  }

  ///
  ///
  ///
  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}

///
/// https://developer.github.com/v3/users/
///
class Plan {
  String name;
  int space;
  int privateRepos;
  int collaborators;

  ///
  ///
  ///
  Plan({
    this.name,
    this.space,
    this.privateRepos,
    this.collaborators,
  });

  ///
  ///
  ///
  Plan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    space = json['space'];
    privateRepos = json['private_repos'];
    collaborators = json['collaborators'];
    privateRepos = json['private_repos'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['space'] = space;
    data['private_repos'] = privateRepos;
    data['collaborators'] = collaborators;
    data['private_repos'] = privateRepos;
    return data;
  }
}
