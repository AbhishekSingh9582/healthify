class LabTest {
  int? price;
  String? testId;
  String? testLabel;
  List<String>? testList;
  int? totalTestInclude;

  LabTest(
      {this.price,
      this.testId,
      this.testLabel,
      this.testList,
      this.totalTestInclude});

  LabTest.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    testId = json['testId'];
    testLabel = json['testLabel'];
    testList = json['testList'].cast<String>();
    totalTestInclude = json['totalTestInclude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['testId'] = this.testId;
    data['testLabel'] = this.testLabel;
    data['testList'] = this.testList;
    data['totalTestInclude'] = this.totalTestInclude;
    return data;
  }
}
