class Aluno {
  String? studentId;
  String? student;
  bool? studentPresent;

  Aluno({this.studentId, this.student, this.studentPresent});

  Aluno.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    student = json['student'];
    studentPresent = json['studentPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['student'] = this.student;
    data['studentPresent'] = this.studentPresent;
    return data;
  }
}
