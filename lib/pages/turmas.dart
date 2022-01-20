class Turma {
  String? name;
  String? room;
  int? gradeId;
  String? gradeName;
  int? shift;
  bool? deleted;
  int? managerId;
  int? id;

  Turma(
      {this.name,
      this.room,
      this.gradeId,
      this.gradeName,
      this.shift,
      this.deleted,
      this.managerId,
      this.id});

  Turma.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    room = json['room'];
    gradeId = json['gradeId'];
    gradeName = json['gradeName'];
    shift = json['shift'];
    deleted = json['deleted'];
    managerId = json['managerId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['room'] = this.room;
    data['gradeId'] = this.gradeId;
    data['gradeName'] = this.gradeName;
    data['shift'] = this.shift;
    data['deleted'] = this.deleted;
    data['managerId'] = this.managerId;
    data['id'] = this.id;
    return data;
  }
}
