class TodoModel {
  final String? heading;
  final String? description;
  final String? id;

  /// Construtor to receive the data from api nullable
  TodoModel({this.heading, this.description, this.id});

  /// Construtor to create a new instance with all required feild
  TodoModel.create({
    required this.heading,
    required this.description,
    required this.id,
  });
}
