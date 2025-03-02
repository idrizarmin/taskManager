import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:task_manager/common/constants/constants.dart';
import 'package:task_manager/feature/domain/models/request_models/task_request_model.dart';
import 'package:task_manager/feature/domain/models/response_models/task_response_model.dart';
import 'package:task_manager/feature/domain/models/response_models/task_upsert_response_model.dart';

class TaskRepository {
  Future<List<TaskResponseModel>> load() async {
    try {
      final response = await http.get(Uri.parse(Constansts.apiUrlGetAndPost));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.isEmpty) {
          return [];
        }

        return data.entries.map((entry) {
          return TaskResponseModel.fromJson(entry.key, entry.value);
        }).toList();
      } else {
        throw Exception("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      return [];
    }
  }

  Future<TaskUpsertResponseModel> add(TaskRequestModel taskModel) async {
    try {
      final response = await http.post(
        Uri.parse(Constansts.apiUrlGetAndPost),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(taskModel.toJson()),
      );

      if (response.statusCode == HttpStatus.ok) {
        return TaskUpsertResponseModel.fromJson(json.decode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception("Fail to upsert task.");
    }
  }

  Future delete(String taskId) async {
    try {
      final String url = "${Constansts.apiUrlDelete}/$taskId/.json";

      await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw Exception("Fail to delete task.");
    }
  }
}
