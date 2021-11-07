import 'package:flutter_github_profile/models/profile.dart';

class Repository {
  final String name;
  final String fullName;
  final String htmlUrl;
  final String description;
  final String updatedAt;
  final String language;
  final bool isForked;
  final int stargazersCount;
  final int watchers;
  final int openPullRequestCount;
  final Profile owner;

  Repository(
      this.name,
      this.fullName,
      this.htmlUrl,
      this.description,
      this.updatedAt,
      this.language,
      this.isForked,
      this.stargazersCount,
      this.watchers,
      this.openPullRequestCount,
      this.owner);

  Repository.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        fullName = json["full_name"],
        htmlUrl = json["html_url"],
        description = json["description"],
        updatedAt = json["updated_at"],
        language = json["language"],
        isForked = json["fork"],
        stargazersCount = json["stargazers_count"],
        watchers = json["watchers"],
        openPullRequestCount = json["open_issues_count"],
        owner = json["owner"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "full_name": fullName,
        "html_url": htmlUrl,
        "description": description,
        "updated_at": updatedAt,
        "language": language,
        "fork": isForked,
        "stargazers_count": stargazersCount,
        "watchers": watchers,
        "open_issues_count": openPullRequestCount,
        "owner": owner,
      };
}
