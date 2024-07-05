class Subject {
  final int? id;
   String name;
   int age;

  Subject({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    print(map);
    return  Subject(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}