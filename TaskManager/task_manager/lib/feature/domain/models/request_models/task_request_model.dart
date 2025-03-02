class TaskRequestModel {
  final String title;
  final String description;
  final bool isActive = true;

  TaskRequestModel({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'isActive': isActive};
  }
}
