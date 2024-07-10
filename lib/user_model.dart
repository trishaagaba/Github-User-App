class User {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final int followers;
  final int publicRepos;

  User({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.followers,
    required this.publicRepos,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
      followers: json['followers'],
      publicRepos: json['public_repos'],
    );
  }
}
