class Profile {
  final String login;
  final String name;
  final String bio;
  final String avatarUrl;
  final int followers;
  final int following;

  Profile(this.login, this.name, this.bio, this.avatarUrl, this.followers,
      this.following);

  Profile.fromJson(Map<String, dynamic> json)
      : login = json["login"],
        name = json["name"],
        bio = json["bio"],
        avatarUrl = json["avatar_url"],
        followers = json["followers"],
        following = json["following"];

  Map<String, dynamic> toJson() => {
        "login": login,
        "name": name,
        "bio": bio,
        "avatar_url": avatarUrl,
        "followers": followers,
        "following": following,
      };
}
