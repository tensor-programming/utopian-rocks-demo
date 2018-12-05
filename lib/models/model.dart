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
