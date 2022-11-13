class MeetListData {
  MeetListData({
    this.meetingLink = '',
    this.titleTxt = '',
    this.subTxt = "",

  });

  String meetingLink;
  String titleTxt;
  String subTxt;


  static List<MeetListData> meetList = <MeetListData>[
    MeetListData(
      meetingLink: 'assets/hotel/zoom.jpg',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',

    ),
    MeetListData(
      meetingLink: 'http://12us.zoom.us/werts123',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',


    ),
    MeetListData(
      meetingLink: 'http://12us.zoom.us/werts123',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',

    ),
    MeetListData(
      meetingLink: 'http://12us.zoom.us/werts123',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',

    ),
    MeetListData(
      meetingLink: 'http://12us.zoom.us/werts123',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',

    ),
  ];
}
