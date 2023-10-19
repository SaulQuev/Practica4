class CareerModel {
  int? career_id;
  String? career_name;

  CareerModel({this.career_id, this.career_name});

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
        career_id: map['career_id'], career_name: map['career_name']);
  }
}
