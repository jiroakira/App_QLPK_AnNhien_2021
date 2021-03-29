class VisitedDoctor {
  String id;
  Doctor doctor;

  VisitedDoctor({this.id, this.doctor});

  factory VisitedDoctor.fromJson(Map<String, dynamic> json) {
    return VisitedDoctor(
      id: json['id'],
      doctor: Doctor.fromJson(json['doctor']),
    );
  }
}

class Doctor {
  String name;
  String phone;
  String email;

  Doctor({this.name, this.phone, this.email});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class ListVisitedDoctor {
  final List<VisitedDoctor> visitedDoctor;

  ListVisitedDoctor({this.visitedDoctor});

  factory ListVisitedDoctor.fromJson(List<dynamic> json) {
    List<VisitedDoctor> listVisitedDoctor = new List<VisitedDoctor>();
    listVisitedDoctor = json.map((e) => VisitedDoctor.fromJson(e)).toList();
    return ListVisitedDoctor(
      visitedDoctor: listVisitedDoctor,
    );
  }
}
