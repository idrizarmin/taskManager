class TaskResponseModel {
  final String id;
  final String title;
  final String description;

  bool isActive;

  TaskResponseModel({
    required this.id,
    required this.title,
    required this.description,
    this.isActive = true,
  });

  factory TaskResponseModel.fromJson(String id, Map<String, dynamic> json) {
    return TaskResponseModel(
      id: id,
      title: json['title'],
      description: json['description'],
      isActive: json['isActive'] ?? true,
    );
  }

  TaskResponseModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isActive,
  }) {
    return TaskResponseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}
