class VideoListData {
  String id;
  String imagePath;
  String title;
  String description;
  String speaker;
  String videoUrl;
  String uploadDate;
  String expireDate;



  DateTime date = DateTime.now();

  VideoListData({
    this.id = '',
    this.imagePath = '',
    this.title = '',
    this.description = '',
    this.speaker = '',
    this.uploadDate = '',
    this.expireDate = '',
    this.videoUrl = '',

  });

  static VideoListData fromJson(Map<String, dynamic> json) => VideoListData(
    id: json['id'],
    imagePath: json['image_path'],
    title: json['name'],
    description: json['description'],
    speaker: json['speaker'],
    videoUrl:  json['videoUrl'],
    uploadDate: json['start_date'],
    expireDate: json['end_date'],


  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image_path': imagePath,
    'name': title,
    'description': description,
    'speaker': speaker,
    'videoUrl': videoUrl,
    'start_date': uploadDate,
    'end_date': expireDate,

  };
}
