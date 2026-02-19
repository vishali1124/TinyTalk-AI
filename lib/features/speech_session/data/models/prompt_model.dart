import '../../domain/entities/prompt.dart';

class PromptModel {
  final String id;
  final String text;

  PromptModel({required this.id, required this.text});

  factory PromptModel.fromJson(Map<String, dynamic> json) {
    return PromptModel(
      id: json["id"].toString(),
      text: json["text"] ?? "",
    );
  }

  Prompt toEntity() => Prompt(id: id, text: text);
}
