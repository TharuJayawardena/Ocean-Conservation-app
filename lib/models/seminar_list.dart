class SeminarListData {
  String id;
  String meetingLink;
  String title;
  String description;
  String organizer;
  String startDate;
  String endDate;
  String startTime;


  DateTime date = DateTime.now();

  SeminarListData( {
    this.id = '',
    this.meetingLink = '',
    this.title = '',
    this.description = '',
    this.organizer = '',
    this.startDate = '',
    this.endDate = '',
    this.startTime = ''
  });

  static  SeminarListData fromJson(Map<String, dynamic> json) =>  SeminarListData(
    id: json['id'],
    meetingLink: json['meetingLink'],
    title: json['name'],
    description: json['description'],
    organizer: json['organizer'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    startTime: json['start_time']

  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'meetingLink': meetingLink,
    'name': title,
    'description': description,
    'organizer': organizer,
    'start_date': startDate,
    'end_date': endDate,
    'start_time': startTime
  };
}
