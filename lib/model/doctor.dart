class Doctor {
  String? category;
  String? doctorImage;
  String? experience;
  String? id;
  String? name;
  int? patients;
  int? star;

  Doctor(
      {this.category,
      this.doctorImage,
      this.experience,
      this.id,
      this.name,
      this.patients,
      this.star});

  Doctor.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    doctorImage = json['doctorImage'];
    experience = json['experience'];
    id = json['id'];
    name = json['name'];
    patients = json['patients'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['doctorImage'] = this.doctorImage;
    data['experience'] = this.experience;
    data['id'] = this.id;
    data['name'] = this.name;
    data['patients'] = this.patients;
    data['star'] = this.star;
    return data;
  }
}
