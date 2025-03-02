class TaskUpsertResponseModel {
  final String id;

  TaskUpsertResponseModel({required this.id});

  factory TaskUpsertResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskUpsertResponseModel(id: json['name']);
  }
}
