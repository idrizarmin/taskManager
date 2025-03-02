import 'package:flutter/material.dart';
import 'package:task_manager/common/constants/constants.dart';

typedef TaskAddWidgetConfirmed =
    void Function(String title, String description);

class TaskAddWidget extends StatefulWidget {
  final TaskAddWidgetConfirmed onConfirmed;

  const TaskAddWidget({super.key, required this.onConfirmed});

  static Future show(
    BuildContext context, {

    required TaskAddWidgetConfirmed onConfirmed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TaskAddWidget(onConfirmed: onConfirmed);
      },
    );
  }

  @override
  State<TaskAddWidget> createState() => _TaskAddWidgetState();
}

class _TaskAddWidgetState extends State<TaskAddWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      if (_titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty) {
        widget.onConfirmed(_titleController.text, _descriptionController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Constansts.enterTitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constansts.titleIsRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      Constansts.enterDescription,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Constansts.descriptionIsRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onSubmitPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          Constansts.addTask,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
