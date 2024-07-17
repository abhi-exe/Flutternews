class Article{
   String author;
   String descrp;
   String title;
   String publishedAt;
   String content;
   String sourceid;
   String sourcename;
   String imageurl;
   String url;

  Article({
    required this.author,
    required this.title,
    required this.descrp,
    required this.publishedAt,
    required this.content,
    required this.sourceid,
    required this.sourcename,
    required this.imageurl,
    required this.url,
   });

   factory Article.fromJson(Map<String, dynamic> json){
    return Article(author: json['author'],
    title: json['title'],
    descrp: json['description'],
    publishedAt: json['publishedAt'],
    content: json['content'],
    sourceid: json['source']['id'],
    sourcename: json['source']['name'],
    imageurl: json['urlToImage'],
    url: json['url']
    );
   }
}