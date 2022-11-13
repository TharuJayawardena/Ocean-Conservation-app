class ArticleListData {
  String id;
  String imagePath;
  String title;
  String description;
  String author;
  String startDate;
  String endDate;


  DateTime date = DateTime.now();

  ArticleListData({
    this.id = '',
    this.imagePath = '',
    this.title = '',
    this.description = '',
    this.author = '',
    this.startDate = '',
    this.endDate = '',

  });

  static ArticleListData fromJson(Map<String, dynamic> json) => ArticleListData(
    id: json['id'],
    imagePath: json['image_path'],
    title: json['name'],
    description: json['description'],
    author: json['author'],
    startDate: json['start_date'],
    endDate: json['end_date'],

  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image_path': imagePath,
    'name': title,
    'description': description,
    'author': author,
    'start_date': startDate,
    'end_date': endDate,

  };
}
