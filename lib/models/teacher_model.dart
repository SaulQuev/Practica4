class TeacherModel {
  int? teacher_id;
  String? teacher_name;
  String? teacher_email;
  int? career_id;

  TeacherModel(
      {this.teacher_id, this.teacher_name, this.teacher_email, this.career_id});

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
        teacher_id: map['teacher_id'],
        teacher_name: map['teacher_name'],
        teacher_email: map['teacher_email'],
        career_id: map['career_id']);
  }
}
