class RegretModel {
  final String regret;
  final String lesson;
  final String category;
  final String date;

  RegretModel({
    required this.regret,
    required this.lesson,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'regret': regret,
    'lesson': lesson,
    'category': category,
    'date': date,
  };

  factory RegretModel.fromJson(Map<String, dynamic> json) {
    return RegretModel(
      regret: json['regret'],
      lesson: json['lesson'],
      category: json['category'],
      date: json['date'],
    );
  }
}