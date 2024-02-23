class TodoModels {
  final String? id;
  final String taskName;
  final String description;
  final String dueDate;
  final String status;

  TodoModels({
    this.id,
    required this.taskName,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  TodoModels copyWith({
    String? id,
    String? taskName,
    String? description,
    String? dueDate,
    String? status,
  }) {
    return TodoModels(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  factory TodoModels.fromJson(Map<String, dynamic> json) {
    return TodoModels(
      id: json['id'],
      taskName: json['task_name'],
      description: json['description'],
      dueDate: json['due_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data["task_name"] = taskName;
    data["description"] = description;
    data["due_date"] = dueDate;
    data["status"] = status;
    
    return data;
  }
}
