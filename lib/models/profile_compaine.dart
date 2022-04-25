class ProfileCompany {
  int? id;
  String? name;
  String? address;
  String? desc;
  String? image;
  List<Reviews>? reviews;
  List<Social>? social;
  List<Files>? files;
  dynamic total_rating;
  dynamic lat;
  dynamic lon;
  dynamic pdf;
  dynamic tel;
  dynamic phone1;
  dynamic phone2;
  dynamic fax;
  dynamic visit_count;
  dynamic fav;
  dynamic open_from;
  dynamic open_to;
  dynamic is_open;
  dynamic owner;
  dynamic location;
  dynamic week_from;
  dynamic week_to;
  dynamic closed_reason;
  dynamic is_review;
  Category? category;

  ProfileCompany(
      {this.id,
      this.name,
      this.category,
      this.address,
      this.desc,
      this.image,
      this.reviews,
      this.social,
      this.files,
      this.total_rating,
      this.lat,
      this.lon,
      this.pdf,
      this.tel,
      this.phone1,
      this.phone2,
      this.fax,
      this.visit_count,
      this.fav,
      this.open_from,
      this.open_to,
      this.is_open,
      this.owner,
      this.location,
      this.week_from,
      this.week_to,
      this.is_review,
      this.closed_reason});

  factory ProfileCompany.fromJson(json) {
    final List<Reviews> reviews = [];
    for (var review in json['reviews']) {
      reviews.add(Reviews.fromJson(review));
    }
    print('done Reviews');
    final List<Social> social = [];
    for (var soc in json['socials']) {
      social.add(Social.fromJson(soc));
    }
    print('done Social');
    final List<Files> files = [];
    for (var file in json['files']) {
      files.add(Files.fromJson(file));
    }
    print('done files');
    var cat = Category.fromJson(json['category']);
    final category = cat;
    print('done city');
    print('done ok');
    return ProfileCompany(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      desc: json['desc'],
      image: json['image'],
      reviews: reviews,
      social: social,
      files: files,
      total_rating: json['total_rating'],
      lat: json['lat'].toDouble(),
      lon: json['lng'].toDouble(),
      pdf: json['pdf'],
      tel: json['tel'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      fax: json['fax'],
      visit_count: json['visit_count'],
      fav: json['fav'],
      is_open: json['is_open'],
      open_from: json['open_from'],
      open_to: json['open_to'],
      owner: json['owner'],
      location: json['location'],
      week_from: json['week_from'],
      week_to: json['week_to'],
      closed_reason: json['closed_reason'],
      is_review: json['is_review'],
      category: category,
    );
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});
  factory Category.fromJson(json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Social {
  String? link;
  String? icon_type;
  int? socialable_id;
  String? socialable_type;

  Social({this.link, this.icon_type, this.socialable_id, this.socialable_type});
  factory Social.fromJson(json) {
    return Social(
      link: json['link'],
      icon_type: json['icon_type'],
      socialable_id: json['socialable_id'],
      socialable_type: json['socialable_type'],
    );
  }
}

class Files {
  int? id;
  String? source;

  Files({this.id, this.source});

  factory Files.fromJson(json) {
    return Files(
      id: json['id'],
      source: json['source'],
    );
  }
}

class Reviews {
  int? id;
  dynamic comment;
  dynamic rate;
  int? user_id;
  int? company_id;
  int? likes_count;
  int? dislikens_count;
  dynamic created_at;
  User? user;
  List<CommentLikeAndDislike>? comment_likes;
  List<CommentLikeAndDislike>? comment_dis_likes;

  Reviews(
      {this.id,
      this.comment,
      this.rate,
      this.user_id,
      this.company_id,
      this.likes_count,
      this.dislikens_count,
      this.created_at,
      this.user,
      this.comment_likes,
      this.comment_dis_likes});

  factory Reviews.fromJson(json) {
    var u = User.fromJson(json['user']);
    final user = u;
    print('done User');
    final List<CommentLikeAndDislike> comment_likes = [];
    for (var comment_like in json['comment_likes']) {
      comment_likes.add(CommentLikeAndDislike.fromJson(comment_like));
    }
    print('done CommentLike');
    final List<CommentLikeAndDislike> comment_dis_likes = [];
    for (var comment_dis_like in json['comment_dis_likes']) {
      comment_dis_likes.add(CommentLikeAndDislike.fromJson(comment_dis_like));
    }
    print('done CommentDislike');

    return Reviews(
      id: json['id'],
      comment: json['comment'],
      rate: json['rate'],
      user_id: json['user_id'],
      company_id: json['company_id'],
      created_at: json['created_at'],
      likes_count: json['likes_count'],
      dislikens_count: json['dislikens_count'],
      user: user,
    );
  }
}

class User {
  int? id;
  String? name;
  String? avatar;

  User({this.id, this.name, this.avatar});

  factory User.fromJson(json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}

class CommentLikeAndDislike {
  int? id;
  int? user_id;
  int? review_id;
  int? type;
  String? reson;

  CommentLikeAndDislike(
      {this.id, this.user_id, this.review_id, this.type, this.reson});

  factory CommentLikeAndDislike.fromJson(json) {
    return CommentLikeAndDislike(
      id: json['id'],
      user_id: json['user_id'],
      review_id: json['review_id'],
      type: json['type'],
      reson: json['reson'],
    );
  }
}
