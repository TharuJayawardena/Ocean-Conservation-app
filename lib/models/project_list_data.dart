class ProjectListData {
  String id;
  String uid;
  String imagePath;
  String title;
  String description;
  String organizer;
  String startDate;
  String endDate;
  int fundAmount;
  bool fund;

  DateTime date = DateTime.now();

  ProjectListData({
    this.id = '',
    this.uid = '',
    this.imagePath = '',
    this.title = '',
    this.description = '',
    this.organizer = '',
    this.startDate = '',
    this.endDate = '',
    this.fundAmount = 0,
    this.fund = true,
  });

  static ProjectListData fromJson(Map<String, dynamic> json) => ProjectListData(
        id: json['id'],
        uid: json['uid'],
        imagePath: json['image_path'],
        title: json['name'],
        description: json['description'],
        organizer: json['organizer'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        fundAmount: json['fund_amount'],
        fund: json['fund'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'image_path': imagePath,
        'name': title,
        'description': description,
        'organizer': organizer,
        'start_date': startDate,
        'end_date': endDate,
        'fund': fund,
        'fund_amount': fundAmount
      };
}
