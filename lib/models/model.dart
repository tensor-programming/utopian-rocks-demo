class Contribution {
  final String author;
  final String category;
  final String moderator;
  final String repository;
  final String created;
  final String reviewDate;
  final String title;
  final double totalPayout;
  final String url;
  final String status;

  Contribution({
    this.author,
    this.category,
    this.moderator,
    this.repository,
    this.created,
    this.reviewDate,
    this.title,
    this.totalPayout,
    this.url,
    this.status,
  });

  Contribution.fromJson(Map json)
      : author = json['author'],
        category = (json['category'] as String)
            .replaceFirst('-task', '')
            .replaceFirst("task-", ''),
        moderator = json['moderator'],
        repository = (json['repository'] as String)
            .replaceFirst('https://github.com/', ''),
        title = json['title'],
        totalPayout = json['total_payout'] as double,
        url = json['url'],
        created = json['created'],
        reviewDate = json['review_date'],
        status = json['status'];
}

class GithubModel {
  final String tagName;
  final String htmlUrl;

  GithubModel(this.tagName, this.htmlUrl);

  GithubModel.fromJson(Map json)
      : this.tagName = json['tag_name'],
        this.htmlUrl = json['html_url'];
}

class SteemResponse {
  final String lastVoteTime;
  final int votingPower;

  SteemResponse(this.lastVoteTime, this.votingPower);

  SteemResponse.fromJson(Map json)
      : this.lastVoteTime = json["last_vote_time"],
        this.votingPower = json["voting_power"];
}




//  {
//     "url": "https://api.github.com/repos/tensor-programming/utopian-rocks-mobile/releases/12924753",
//     "assets_url": "https://api.github.com/repos/tensor-programming/utopian-rocks-mobile/releases/12924753/assets",
//     "upload_url": "https://uploads.github.com/repos/tensor-programming/utopian-rocks-mobile/releases/12924753/assets{?name,label}",
//     "html_url": "https://github.com/tensor-programming/utopian-rocks-mobile/releases/tag/0.1.0",
//     "id": 12924753,
//     "node_id": "MDc6UmVsZWFzZTEyOTI0NzUz",
//     "tag_name": "0.1.0",
//     "target_commitish": "master",
//     "name": "Prerelease version 0.1.0",
//     "draft": false,
//     "author": {
//       "login": "tensor-programming",
//       "id": 22513880,
//       "node_id": "MDQ6VXNlcjIyNTEzODgw",
//       "avatar_url": "https://avatars0.githubusercontent.com/u/22513880?v=4",
//       "gravatar_id": "",
//       "url": "https://api.github.com/users/tensor-programming",
//       "html_url": "https://github.com/tensor-programming",
//       "followers_url": "https://api.github.com/users/tensor-programming/followers",
//       "following_url": "https://api.github.com/users/tensor-programming/following{/other_user}",
//       "gists_url": "https://api.github.com/users/tensor-programming/gists{/gist_id}",
//       "starred_url": "https://api.github.com/users/tensor-programming/starred{/owner}{/repo}",
//       "subscriptions_url": "https://api.github.com/users/tensor-programming/subscriptions",
//       "organizations_url": "https://api.github.com/users/tensor-programming/orgs",
//       "repos_url": "https://api.github.com/users/tensor-programming/repos",
//       "events_url": "https://api.github.com/users/tensor-programming/events{/privacy}",
//       "received_events_url": "https://api.github.com/users/tensor-programming/received_events",
//       "type": "User",
//       "site_admin": false
//     },

// Utopian rocks API
// {
//     "author": "froq",
//     "beneficiaries_set": true,
//     "category": "translations",
//     "comment_url": "re-froq-translation-polish-orocommerce-1244-words-10-20181204t160022495z",
//     "created": "2018-12-02 19:52:24",
//     "is_vipo": false,
//     "moderator": "villaincandle",
//     "picked_by": "",
//     "repository": "https://github.com/oroinc/orocommerce-application",
//     "review_date": "2018-12-04 16:02:08",
//     "review_status": "pending",
//     "score": 80.0,
//     "staff_picked": false,
//     "status": "pending",
//     "title": "[Translation][Polish]OroCommerce(1244 words)#10",
//     "total_comments": 2,
//     "total_payout": 1.012,
//     "total_votes": 88,
//     "url": "https://steemit.com/utopian-io/@froq/translation-polish-orocommerce-1244-words-10",
//     "utopian_vote": 0,
//     "valid_age": true,
//     "voted_on": false,
//     "voting_weight": 37.990356105660226
//   },
