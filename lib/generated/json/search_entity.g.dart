import 'package:flutter_deer/generated/json/base/json_convert_content.dart';
import 'package:flutter_deer/order/models/search_entity.dart';

SearchEntity $SearchEntityFromJson(Map<String, dynamic> json) {
	final SearchEntity searchEntity = SearchEntity();
	final int? totalCount = jsonConvert.convert<int>(json['total_count']);
	if (totalCount != null) {
		searchEntity.totalCount = totalCount;
	}
	final bool? incompleteResults = jsonConvert.convert<bool>(json['incomplete_results']);
	if (incompleteResults != null) {
		searchEntity.incompleteResults = incompleteResults;
	}
	final List<SearchItems>? items = jsonConvert.convertListNotNull<SearchItems>(json['items']);
	if (items != null) {
		searchEntity.items = items;
	}
	return searchEntity;
}

Map<String, dynamic> $SearchEntityToJson(SearchEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['total_count'] = entity.totalCount;
	data['incomplete_results'] = entity.incompleteResults;
	data['items'] =  entity.items?.map((v) => v.toJson()).toList();
	return data;
}

SearchItems $SearchItemsFromJson(Map<String, dynamic> json) {
	final SearchItems searchItems = SearchItems();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		searchItems.id = id;
	}
	final String? nodeId = jsonConvert.convert<String>(json['node_id']);
	if (nodeId != null) {
		searchItems.nodeId = nodeId;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		searchItems.name = name;
	}
	final String? fullName = jsonConvert.convert<String>(json['full_name']);
	if (fullName != null) {
		searchItems.fullName = fullName;
	}
	final bool? private = jsonConvert.convert<bool>(json['private']);
	if (private != null) {
		searchItems.private = private;
	}
	final SearchItemsOwner? owner = jsonConvert.convert<SearchItemsOwner>(json['owner']);
	if (owner != null) {
		searchItems.owner = owner;
	}
	final String? htmlUrl = jsonConvert.convert<String>(json['html_url']);
	if (htmlUrl != null) {
		searchItems.htmlUrl = htmlUrl;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		searchItems.description = description;
	}
	final bool? fork = jsonConvert.convert<bool>(json['fork']);
	if (fork != null) {
		searchItems.fork = fork;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		searchItems.url = url;
	}
	final String? forksUrl = jsonConvert.convert<String>(json['forks_url']);
	if (forksUrl != null) {
		searchItems.forksUrl = forksUrl;
	}
	final String? keysUrl = jsonConvert.convert<String>(json['keys_url']);
	if (keysUrl != null) {
		searchItems.keysUrl = keysUrl;
	}
	final String? collaboratorsUrl = jsonConvert.convert<String>(json['collaborators_url']);
	if (collaboratorsUrl != null) {
		searchItems.collaboratorsUrl = collaboratorsUrl;
	}
	final String? teamsUrl = jsonConvert.convert<String>(json['teams_url']);
	if (teamsUrl != null) {
		searchItems.teamsUrl = teamsUrl;
	}
	final String? hooksUrl = jsonConvert.convert<String>(json['hooks_url']);
	if (hooksUrl != null) {
		searchItems.hooksUrl = hooksUrl;
	}
	final String? issueEventsUrl = jsonConvert.convert<String>(json['issue_events_url']);
	if (issueEventsUrl != null) {
		searchItems.issueEventsUrl = issueEventsUrl;
	}
	final String? eventsUrl = jsonConvert.convert<String>(json['events_url']);
	if (eventsUrl != null) {
		searchItems.eventsUrl = eventsUrl;
	}
	final String? assigneesUrl = jsonConvert.convert<String>(json['assignees_url']);
	if (assigneesUrl != null) {
		searchItems.assigneesUrl = assigneesUrl;
	}
	final String? branchesUrl = jsonConvert.convert<String>(json['branches_url']);
	if (branchesUrl != null) {
		searchItems.branchesUrl = branchesUrl;
	}
	final String? tagsUrl = jsonConvert.convert<String>(json['tags_url']);
	if (tagsUrl != null) {
		searchItems.tagsUrl = tagsUrl;
	}
	final String? blobsUrl = jsonConvert.convert<String>(json['blobs_url']);
	if (blobsUrl != null) {
		searchItems.blobsUrl = blobsUrl;
	}
	final String? gitTagsUrl = jsonConvert.convert<String>(json['git_tags_url']);
	if (gitTagsUrl != null) {
		searchItems.gitTagsUrl = gitTagsUrl;
	}
	final String? gitRefsUrl = jsonConvert.convert<String>(json['git_refs_url']);
	if (gitRefsUrl != null) {
		searchItems.gitRefsUrl = gitRefsUrl;
	}
	final String? treesUrl = jsonConvert.convert<String>(json['trees_url']);
	if (treesUrl != null) {
		searchItems.treesUrl = treesUrl;
	}
	final String? statusesUrl = jsonConvert.convert<String>(json['statuses_url']);
	if (statusesUrl != null) {
		searchItems.statusesUrl = statusesUrl;
	}
	final String? languagesUrl = jsonConvert.convert<String>(json['languages_url']);
	if (languagesUrl != null) {
		searchItems.languagesUrl = languagesUrl;
	}
	final String? stargazersUrl = jsonConvert.convert<String>(json['stargazers_url']);
	if (stargazersUrl != null) {
		searchItems.stargazersUrl = stargazersUrl;
	}
	final String? contributorsUrl = jsonConvert.convert<String>(json['contributors_url']);
	if (contributorsUrl != null) {
		searchItems.contributorsUrl = contributorsUrl;
	}
	final String? subscribersUrl = jsonConvert.convert<String>(json['subscribers_url']);
	if (subscribersUrl != null) {
		searchItems.subscribersUrl = subscribersUrl;
	}
	final String? subscriptionUrl = jsonConvert.convert<String>(json['subscription_url']);
	if (subscriptionUrl != null) {
		searchItems.subscriptionUrl = subscriptionUrl;
	}
	final String? commitsUrl = jsonConvert.convert<String>(json['commits_url']);
	if (commitsUrl != null) {
		searchItems.commitsUrl = commitsUrl;
	}
	final String? gitCommitsUrl = jsonConvert.convert<String>(json['git_commits_url']);
	if (gitCommitsUrl != null) {
		searchItems.gitCommitsUrl = gitCommitsUrl;
	}
	final String? commentsUrl = jsonConvert.convert<String>(json['comments_url']);
	if (commentsUrl != null) {
		searchItems.commentsUrl = commentsUrl;
	}
	final String? issueCommentUrl = jsonConvert.convert<String>(json['issue_comment_url']);
	if (issueCommentUrl != null) {
		searchItems.issueCommentUrl = issueCommentUrl;
	}
	final String? contentsUrl = jsonConvert.convert<String>(json['contents_url']);
	if (contentsUrl != null) {
		searchItems.contentsUrl = contentsUrl;
	}
	final String? compareUrl = jsonConvert.convert<String>(json['compare_url']);
	if (compareUrl != null) {
		searchItems.compareUrl = compareUrl;
	}
	final String? mergesUrl = jsonConvert.convert<String>(json['merges_url']);
	if (mergesUrl != null) {
		searchItems.mergesUrl = mergesUrl;
	}
	final String? archiveUrl = jsonConvert.convert<String>(json['archive_url']);
	if (archiveUrl != null) {
		searchItems.archiveUrl = archiveUrl;
	}
	final String? downloadsUrl = jsonConvert.convert<String>(json['downloads_url']);
	if (downloadsUrl != null) {
		searchItems.downloadsUrl = downloadsUrl;
	}
	final String? issuesUrl = jsonConvert.convert<String>(json['issues_url']);
	if (issuesUrl != null) {
		searchItems.issuesUrl = issuesUrl;
	}
	final String? pullsUrl = jsonConvert.convert<String>(json['pulls_url']);
	if (pullsUrl != null) {
		searchItems.pullsUrl = pullsUrl;
	}
	final String? milestonesUrl = jsonConvert.convert<String>(json['milestones_url']);
	if (milestonesUrl != null) {
		searchItems.milestonesUrl = milestonesUrl;
	}
	final String? notificationsUrl = jsonConvert.convert<String>(json['notifications_url']);
	if (notificationsUrl != null) {
		searchItems.notificationsUrl = notificationsUrl;
	}
	final String? labelsUrl = jsonConvert.convert<String>(json['labels_url']);
	if (labelsUrl != null) {
		searchItems.labelsUrl = labelsUrl;
	}
	final String? releasesUrl = jsonConvert.convert<String>(json['releases_url']);
	if (releasesUrl != null) {
		searchItems.releasesUrl = releasesUrl;
	}
	final String? deploymentsUrl = jsonConvert.convert<String>(json['deployments_url']);
	if (deploymentsUrl != null) {
		searchItems.deploymentsUrl = deploymentsUrl;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		searchItems.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		searchItems.updatedAt = updatedAt;
	}
	final String? pushedAt = jsonConvert.convert<String>(json['pushed_at']);
	if (pushedAt != null) {
		searchItems.pushedAt = pushedAt;
	}
	final String? gitUrl = jsonConvert.convert<String>(json['git_url']);
	if (gitUrl != null) {
		searchItems.gitUrl = gitUrl;
	}
	final String? sshUrl = jsonConvert.convert<String>(json['ssh_url']);
	if (sshUrl != null) {
		searchItems.sshUrl = sshUrl;
	}
	final String? cloneUrl = jsonConvert.convert<String>(json['clone_url']);
	if (cloneUrl != null) {
		searchItems.cloneUrl = cloneUrl;
	}
	final String? svnUrl = jsonConvert.convert<String>(json['svn_url']);
	if (svnUrl != null) {
		searchItems.svnUrl = svnUrl;
	}
	final String? homepage = jsonConvert.convert<String>(json['homepage']);
	if (homepage != null) {
		searchItems.homepage = homepage;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		searchItems.size = size;
	}
	final int? stargazersCount = jsonConvert.convert<int>(json['stargazers_count']);
	if (stargazersCount != null) {
		searchItems.stargazersCount = stargazersCount;
	}
	final int? watchersCount = jsonConvert.convert<int>(json['watchers_count']);
	if (watchersCount != null) {
		searchItems.watchersCount = watchersCount;
	}
	final String? language = jsonConvert.convert<String>(json['language']);
	if (language != null) {
		searchItems.language = language;
	}
	final bool? hasIssues = jsonConvert.convert<bool>(json['has_issues']);
	if (hasIssues != null) {
		searchItems.hasIssues = hasIssues;
	}
	final bool? hasProjects = jsonConvert.convert<bool>(json['has_projects']);
	if (hasProjects != null) {
		searchItems.hasProjects = hasProjects;
	}
	final bool? hasDownloads = jsonConvert.convert<bool>(json['has_downloads']);
	if (hasDownloads != null) {
		searchItems.hasDownloads = hasDownloads;
	}
	final bool? hasWiki = jsonConvert.convert<bool>(json['has_wiki']);
	if (hasWiki != null) {
		searchItems.hasWiki = hasWiki;
	}
	final bool? hasPages = jsonConvert.convert<bool>(json['has_pages']);
	if (hasPages != null) {
		searchItems.hasPages = hasPages;
	}
	final int? forksCount = jsonConvert.convert<int>(json['forks_count']);
	if (forksCount != null) {
		searchItems.forksCount = forksCount;
	}
	final bool? archived = jsonConvert.convert<bool>(json['archived']);
	if (archived != null) {
		searchItems.archived = archived;
	}
	final bool? disabled = jsonConvert.convert<bool>(json['disabled']);
	if (disabled != null) {
		searchItems.disabled = disabled;
	}
	final int? openIssuesCount = jsonConvert.convert<int>(json['open_issues_count']);
	if (openIssuesCount != null) {
		searchItems.openIssuesCount = openIssuesCount;
	}
	final SearchItemsLicense? license = jsonConvert.convert<SearchItemsLicense>(json['license']);
	if (license != null) {
		searchItems.license = license;
	}
	final int? forks = jsonConvert.convert<int>(json['forks']);
	if (forks != null) {
		searchItems.forks = forks;
	}
	final int? openIssues = jsonConvert.convert<int>(json['open_issues']);
	if (openIssues != null) {
		searchItems.openIssues = openIssues;
	}
	final int? watchers = jsonConvert.convert<int>(json['watchers']);
	if (watchers != null) {
		searchItems.watchers = watchers;
	}
	final String? defaultBranch = jsonConvert.convert<String>(json['default_branch']);
	if (defaultBranch != null) {
		searchItems.defaultBranch = defaultBranch;
	}
	final double? score = jsonConvert.convert<double>(json['score']);
	if (score != null) {
		searchItems.score = score;
	}
	return searchItems;
}

Map<String, dynamic> $SearchItemsToJson(SearchItems entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['node_id'] = entity.nodeId;
	data['name'] = entity.name;
	data['full_name'] = entity.fullName;
	data['private'] = entity.private;
	data['owner'] = entity.owner?.toJson();
	data['html_url'] = entity.htmlUrl;
	data['description'] = entity.description;
	data['fork'] = entity.fork;
	data['url'] = entity.url;
	data['forks_url'] = entity.forksUrl;
	data['keys_url'] = entity.keysUrl;
	data['collaborators_url'] = entity.collaboratorsUrl;
	data['teams_url'] = entity.teamsUrl;
	data['hooks_url'] = entity.hooksUrl;
	data['issue_events_url'] = entity.issueEventsUrl;
	data['events_url'] = entity.eventsUrl;
	data['assignees_url'] = entity.assigneesUrl;
	data['branches_url'] = entity.branchesUrl;
	data['tags_url'] = entity.tagsUrl;
	data['blobs_url'] = entity.blobsUrl;
	data['git_tags_url'] = entity.gitTagsUrl;
	data['git_refs_url'] = entity.gitRefsUrl;
	data['trees_url'] = entity.treesUrl;
	data['statuses_url'] = entity.statusesUrl;
	data['languages_url'] = entity.languagesUrl;
	data['stargazers_url'] = entity.stargazersUrl;
	data['contributors_url'] = entity.contributorsUrl;
	data['subscribers_url'] = entity.subscribersUrl;
	data['subscription_url'] = entity.subscriptionUrl;
	data['commits_url'] = entity.commitsUrl;
	data['git_commits_url'] = entity.gitCommitsUrl;
	data['comments_url'] = entity.commentsUrl;
	data['issue_comment_url'] = entity.issueCommentUrl;
	data['contents_url'] = entity.contentsUrl;
	data['compare_url'] = entity.compareUrl;
	data['merges_url'] = entity.mergesUrl;
	data['archive_url'] = entity.archiveUrl;
	data['downloads_url'] = entity.downloadsUrl;
	data['issues_url'] = entity.issuesUrl;
	data['pulls_url'] = entity.pullsUrl;
	data['milestones_url'] = entity.milestonesUrl;
	data['notifications_url'] = entity.notificationsUrl;
	data['labels_url'] = entity.labelsUrl;
	data['releases_url'] = entity.releasesUrl;
	data['deployments_url'] = entity.deploymentsUrl;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['pushed_at'] = entity.pushedAt;
	data['git_url'] = entity.gitUrl;
	data['ssh_url'] = entity.sshUrl;
	data['clone_url'] = entity.cloneUrl;
	data['svn_url'] = entity.svnUrl;
	data['homepage'] = entity.homepage;
	data['size'] = entity.size;
	data['stargazers_count'] = entity.stargazersCount;
	data['watchers_count'] = entity.watchersCount;
	data['language'] = entity.language;
	data['has_issues'] = entity.hasIssues;
	data['has_projects'] = entity.hasProjects;
	data['has_downloads'] = entity.hasDownloads;
	data['has_wiki'] = entity.hasWiki;
	data['has_pages'] = entity.hasPages;
	data['forks_count'] = entity.forksCount;
	data['archived'] = entity.archived;
	data['disabled'] = entity.disabled;
	data['open_issues_count'] = entity.openIssuesCount;
	data['license'] = entity.license?.toJson();
	data['forks'] = entity.forks;
	data['open_issues'] = entity.openIssues;
	data['watchers'] = entity.watchers;
	data['default_branch'] = entity.defaultBranch;
	data['score'] = entity.score;
	return data;
}

SearchItemsOwner $SearchItemsOwnerFromJson(Map<String, dynamic> json) {
	final SearchItemsOwner searchItemsOwner = SearchItemsOwner();
	final String? login = jsonConvert.convert<String>(json['login']);
	if (login != null) {
		searchItemsOwner.login = login;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		searchItemsOwner.id = id;
	}
	final String? nodeId = jsonConvert.convert<String>(json['node_id']);
	if (nodeId != null) {
		searchItemsOwner.nodeId = nodeId;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		searchItemsOwner.avatarUrl = avatarUrl;
	}
	final String? gravatarId = jsonConvert.convert<String>(json['gravatar_id']);
	if (gravatarId != null) {
		searchItemsOwner.gravatarId = gravatarId;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		searchItemsOwner.url = url;
	}
	final String? htmlUrl = jsonConvert.convert<String>(json['html_url']);
	if (htmlUrl != null) {
		searchItemsOwner.htmlUrl = htmlUrl;
	}
	final String? followersUrl = jsonConvert.convert<String>(json['followers_url']);
	if (followersUrl != null) {
		searchItemsOwner.followersUrl = followersUrl;
	}
	final String? followingUrl = jsonConvert.convert<String>(json['following_url']);
	if (followingUrl != null) {
		searchItemsOwner.followingUrl = followingUrl;
	}
	final String? gistsUrl = jsonConvert.convert<String>(json['gists_url']);
	if (gistsUrl != null) {
		searchItemsOwner.gistsUrl = gistsUrl;
	}
	final String? starredUrl = jsonConvert.convert<String>(json['starred_url']);
	if (starredUrl != null) {
		searchItemsOwner.starredUrl = starredUrl;
	}
	final String? subscriptionsUrl = jsonConvert.convert<String>(json['subscriptions_url']);
	if (subscriptionsUrl != null) {
		searchItemsOwner.subscriptionsUrl = subscriptionsUrl;
	}
	final String? organizationsUrl = jsonConvert.convert<String>(json['organizations_url']);
	if (organizationsUrl != null) {
		searchItemsOwner.organizationsUrl = organizationsUrl;
	}
	final String? reposUrl = jsonConvert.convert<String>(json['repos_url']);
	if (reposUrl != null) {
		searchItemsOwner.reposUrl = reposUrl;
	}
	final String? eventsUrl = jsonConvert.convert<String>(json['events_url']);
	if (eventsUrl != null) {
		searchItemsOwner.eventsUrl = eventsUrl;
	}
	final String? receivedEventsUrl = jsonConvert.convert<String>(json['received_events_url']);
	if (receivedEventsUrl != null) {
		searchItemsOwner.receivedEventsUrl = receivedEventsUrl;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		searchItemsOwner.type = type;
	}
	final bool? siteAdmin = jsonConvert.convert<bool>(json['site_admin']);
	if (siteAdmin != null) {
		searchItemsOwner.siteAdmin = siteAdmin;
	}
	return searchItemsOwner;
}

Map<String, dynamic> $SearchItemsOwnerToJson(SearchItemsOwner entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['login'] = entity.login;
	data['id'] = entity.id;
	data['node_id'] = entity.nodeId;
	data['avatar_url'] = entity.avatarUrl;
	data['gravatar_id'] = entity.gravatarId;
	data['url'] = entity.url;
	data['html_url'] = entity.htmlUrl;
	data['followers_url'] = entity.followersUrl;
	data['following_url'] = entity.followingUrl;
	data['gists_url'] = entity.gistsUrl;
	data['starred_url'] = entity.starredUrl;
	data['subscriptions_url'] = entity.subscriptionsUrl;
	data['organizations_url'] = entity.organizationsUrl;
	data['repos_url'] = entity.reposUrl;
	data['events_url'] = entity.eventsUrl;
	data['received_events_url'] = entity.receivedEventsUrl;
	data['type'] = entity.type;
	data['site_admin'] = entity.siteAdmin;
	return data;
}

SearchItemsLicense $SearchItemsLicenseFromJson(Map<String, dynamic> json) {
	final SearchItemsLicense searchItemsLicense = SearchItemsLicense();
	final String? key = jsonConvert.convert<String>(json['key']);
	if (key != null) {
		searchItemsLicense.key = key;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		searchItemsLicense.name = name;
	}
	final String? spdxId = jsonConvert.convert<String>(json['spdx_id']);
	if (spdxId != null) {
		searchItemsLicense.spdxId = spdxId;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		searchItemsLicense.url = url;
	}
	final String? nodeId = jsonConvert.convert<String>(json['node_id']);
	if (nodeId != null) {
		searchItemsLicense.nodeId = nodeId;
	}
	return searchItemsLicense;
}

Map<String, dynamic> $SearchItemsLicenseToJson(SearchItemsLicense entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['key'] = entity.key;
	data['name'] = entity.name;
	data['spdx_id'] = entity.spdxId;
	data['url'] = entity.url;
	data['node_id'] = entity.nodeId;
	return data;
}