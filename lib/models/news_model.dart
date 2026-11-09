class News {
  final String title;
  final String publisher;
  final String published_at;
  final String uuid;

  News({
    required this.title,
    required this.publisher,
    required this.published_at,
    required this.uuid,
  });
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      publisher: json['publisher'] ?? '',
      published_at: json['published_at'] ?? '',
      uuid: json['uuid'] ?? '',
    );
  }
}

class NewsPageResult {
  final List<News> articles;
  final String? nextCursor;
  final bool hasMore;

  NewsPageResult({
    required this.articles,
    required this.nextCursor,
    required this.hasMore,
  });
}

String PublisherFilter(String publisher){
  if(publisher == "الطاقة - أول منصة عربية متخصصة في أخبار الطاقة")return'الطاقة';
  if(publisher == '新华网')return 'وكالة أنباء شينخوا';
  if(publisher == 'Euronews.com')return 'Euronews';
  if(publisher == 'الموقع الرسمي للنادي الأهلي المصري')return 'النادي الأهلي';
  if(publisher == 'https://inews.ma/')return 'I News';
  return publisher;
}
