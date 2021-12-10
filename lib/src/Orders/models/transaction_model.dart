class Transaction {
  final String name;

  final num value;

  final String? description;

  final DateTime date;

  Transaction({
    required this.name,
    required this.value,
    this.description,
    required this.date,
  });
}
