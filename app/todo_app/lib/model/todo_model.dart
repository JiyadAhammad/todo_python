class TodoModel {
  final String? title;
  final String? description;
  final String? id;

  /// Construtor to receive the data from api nullable
  TodoModel({this.title, this.description, this.id});

  /// Construtor to create a new instance with all required feild
  TodoModel.create({
    required this.title,
    required this.description,
    required this.id,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['descrption'] as String,
    );
  }

  static List<TodoModel> fromList(dynamic json) {
    List<TodoModel> list = [];
    if (json != null && json is List) {
      for (var item in json) {
        list.add(TodoModel.fromJson(item));
      }
    }

    return list;
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "descrption": description};
  }
}
