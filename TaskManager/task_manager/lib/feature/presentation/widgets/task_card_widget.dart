import 'package:flutter/material.dart';

import 'package:task_manager/common/constants/constants.dart';
import 'package:task_manager/feature/domain/models/response_models/task_response_model.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskResponseModel task;
  final VoidCallback onPressedDelete;
  final VoidCallback onPressedEdit;

  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onPressedEdit,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !task.isActive;

    return Card(
      color: isDisabled ? Colors.grey[300] : Colors.teal[50],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color:
                    isDisabled
                        ? Colors.grey[600]
                        : const Color.fromARGB(255, 89, 182, 166),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 16,
                color: isDisabled ? Colors.grey[700] : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color:
                  isDisabled
                      ? Colors.grey
                      : const Color.fromARGB(255, 78, 167, 124),
              thickness: 2,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: onPressedEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDisabled ? Colors.grey : Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(Constansts.endTask),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onPressedDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDisabled ? Colors.grey : Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(Constansts.deleteTask),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
