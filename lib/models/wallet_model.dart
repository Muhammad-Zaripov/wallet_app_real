class WalletModel {
  final int? id;
  final String title;
  final int amount;
  final DateTime date;

  WalletModel({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'amount': amount, 'date': date.toString()};
  }

  WalletModel copyWith({int? id, String? title, int? amount, DateTime? date}) {
    return WalletModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
