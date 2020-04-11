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
