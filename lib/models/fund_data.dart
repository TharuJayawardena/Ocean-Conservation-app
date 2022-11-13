class FundData {
  String id;
  String uid;
  String cardName;
  String cardNo;
  String date;
  int fundAmount;

  FundData({
    this.id = '',
    this.uid = '',
    this.cardName = '',
    this.cardNo = '',
    this.date = '',
    this.fundAmount = 0,
  });

  static FundData fromJson(Map<String, dynamic> json) => FundData(
        id: json['id'],
        uid: json['uid'],
        cardName: json['card_name'],
        cardNo: json['card_no'],
        date: json['date'],
        fundAmount: json['fund_amount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'card_name': cardName,
        'card_no': cardNo,
        'date': date,
        'fund_amount': fundAmount,
      };
}
