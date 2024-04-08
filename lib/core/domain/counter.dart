class Counter {
  final int value;
  final DateTime updatedAt;

  Counter({required this.value, required this.updatedAt});

  factory Counter.fromJson(Map<String, dynamic> json) => Counter(
        value: json['value'] as int,
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}
