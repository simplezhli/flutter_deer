import 'package:flutter_deer/generated/json/base/json_field.dart';
import 'package:flutter_deer/generated/json/search_entity.g.dart';

@JsonSerializable()
class SearchEntity {

	SearchEntity();

	factory SearchEntity.fromJson(Map<String, dynamic> json) => $SearchEntityFromJson(json);

	Map<String, dynamic> toJson() => $SearchEntityToJson(this);

	@JSONField(name: 'total_count')
	int? totalCount;
	@JSONField(name: 'incomplete_results')
	bool? incompleteResults;
	List<SearchItems>? items;
}

@JsonSerializable()
class SearchItems {

	SearchItems();

	factory SearchItems.fromJson(Map<String, dynamic> json) => $SearchItemsFromJson(json);

	Map<String, dynamic> toJson() => $SearchItemsToJson(this);

	int? id;
	@JSONField(name: 'node_id')
	String? nodeId;
	String? name;
	@JSONField(name: 'full_name')
	String? fullName;
	bool? private;
	SearchItemsOwner? owner;
	@JSONField(name: 'html_url')
	String? htmlUrl;
	String? description;
	bool? fork;
	String? url;
	@JSONField(name: 'forks_url')
	String? forksUrl;
	@JSONField(name: 'keys_url')
	String? keysUrl;
	@JSONField(name: 'collaborators_url')
	String? collaboratorsUrl;
	@JSONField(name: 'teams_url')
	String? teamsUrl;
	@JSONField(name: 'hooks_url')
	String? hooksUrl;
	@JSONField(name: 'issue_events_url')
	String? issueEventsUrl;
	@JSONField(name: 'events_url')
	String? eventsUrl;
	@JSONField(name: 'assignees_url')
	String? assigneesUrl;
	@JSONField(name: 'branches_url')
	String? branchesUrl;
	@JSONField(name: 'tags_url')
	String? tagsUrl;
	@JSONField(name: 'blobs_url')
	String? blobsUrl;
	@JSONField(name: 'git_tags_url')
	String? gitTagsUrl;
	@JSONField(name: 'git_refs_url')
	String? gitRefsUrl;
	@JSONField(name: 'trees_url')
	String? treesUrl;
	@JSONField(name: 'statuses_url')
	String? statusesUrl;
	@JSONField(name: 'languages_url')
	String? languagesUrl;
	@JSONField(name: 'stargazers_url')
	String? stargazersUrl;
	@JSONField(name: 'contributors_url')
	String? contributorsUrl;
	@JSONField(name: 'subscribers_url')
	String? subscribersUrl;
	@JSONField(name: 'subscription_url')
	String? subscriptionUrl;
	@JSONField(name: 'commits_url')
	String? commitsUrl;
	@JSONField(name: 'git_commits_url')
	String? gitCommitsUrl;
	@JSONField(name: 'comments_url')
	String? commentsUrl;
	@JSONField(name: 'issue_comment_url')
	String? issueCommentUrl;
	@JSONField(name: 'contents_url')
	String? contentsUrl;
	@JSONField(name: 'compare_url')
	String? compareUrl;
	@JSONField(name: 'merges_url')
	String? mergesUrl;
	@JSONField(name: 'archive_url')
	String? archiveUrl;
	@JSONField(name: 'downloads_url')
	String? downloadsUrl;
	@JSONField(name: 'issues_url')
	String? issuesUrl;
	@JSONField(name: 'pulls_url')
	String? pullsUrl;
	@JSONField(name: 'milestones_url')
	String? milestonesUrl;
	@JSONField(name: 'notifications_url')
	String? notificationsUrl;
	@JSONField(name: 'labels_url')
	String? labelsUrl;
	@JSONField(name: 'releases_url')
	String? releasesUrl;
	@JSONField(name: 'deployments_url')
	String? deploymentsUrl;
	@JSONField(name: 'created_at')
	String? createdAt;
	@JSONField(name: 'updated_at')
	String? updatedAt;
	@JSONField(name: 'pushed_at')
	String? pushedAt;
	@JSONField(name: 'git_url')
	String? gitUrl;
	@JSONField(name: 'ssh_url')
	String? sshUrl;
	@JSONField(name: 'clone_url')
	String? cloneUrl;
	@JSONField(name: 'svn_url')
	String? svnUrl;
	String? homepage;
	int? size;
	@JSONField(name: 'stargazers_count')
	int? stargazersCount;
	@JSONField(name: 'watchers_count')
	int? watchersCount;
	String? language;
	@JSONField(name: 'has_issues')
	bool? hasIssues;
	@JSONField(name: 'has_projects')
	bool? hasProjects;
	@JSONField(name: 'has_downloads')
	bool? hasDownloads;
	@JSONField(name: 'has_wiki')
	bool? hasWiki;
	@JSONField(name: 'has_pages')
	bool? hasPages;
	@JSONField(name: 'forks_count')
	int? forksCount;
	bool? archived;
	bool? disabled;
	@JSONField(name: 'open_issues_count')
	int? openIssuesCount;
	SearchItemsLicense? license;
	int? forks;
	@JSONField(name: 'open_issues')
	int? openIssues;
	int? watchers;
	@JSONField(name: 'default_branch')
	String? defaultBranch;
	double? score;
}

@JsonSerializable()
class SearchItemsOwner {

	SearchItemsOwner();

	factory SearchItemsOwner.fromJson(Map<String, dynamic> json) => $SearchItemsOwnerFromJson(json);

	Map<String, dynamic> toJson() => $SearchItemsOwnerToJson(this);

	String? login;
	int? id;
	@JSONField(name: 'node_id')
	String? nodeId;
	@JSONField(name: 'avatar_url')
	String? avatarUrl;
	@JSONField(name: 'gravatar_id')
	String? gravatarId;
	String? url;
	@JSONField(name: 'html_url')
	String? htmlUrl;
	@JSONField(name: 'followers_url')
	String? followersUrl;
	@JSONField(name: 'following_url')
	String? followingUrl;
	@JSONField(name: 'gists_url')
	String? gistsUrl;
	@JSONField(name: 'starred_url')
	String? starredUrl;
	@JSONField(name: 'subscriptions_url')
	String? subscriptionsUrl;
	@JSONField(name: 'organizations_url')
	String? organizationsUrl;
	@JSONField(name: 'repos_url')
	String? reposUrl;
	@JSONField(name: 'events_url')
	String? eventsUrl;
	@JSONField(name: 'received_events_url')
	String? receivedEventsUrl;
	String? type;
	@JSONField(name: 'site_admin')
	bool? siteAdmin;
}

@JsonSerializable()
class SearchItemsLicense {

	SearchItemsLicense();

	factory SearchItemsLicense.fromJson(Map<String, dynamic> json) => $SearchItemsLicenseFromJson(json);

	Map<String, dynamic> toJson() => $SearchItemsLicenseToJson(this);

	String? key;
	String? name;
	@JSONField(name: 'spdx_id')
	String? spdxId;
	String? url;
	@JSONField(name: 'node_id')
	String? nodeId;
}
