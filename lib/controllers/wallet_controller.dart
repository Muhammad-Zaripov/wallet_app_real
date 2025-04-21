import 'package:flutter/material.dart';

import '../data/database/local_database.dart';
import '../models/wallet_model.dart';

class WalletController {
  WalletController._singleton();
  static final _private = WalletController._singleton();
  factory WalletController() {
    return _private;
  }

  List<WalletModel> costs = [];
  double sum = 0;
  int limitCost = 0;

  double calculatePercent() {
    if (sum > limitCost) {
      return 100;
    }
    if (sum != 0 || limitCost != 0) {
      return (sum / limitCost) * 100;
    }
    return 0;
  }

  final _localDatabase = LocalDatabase();
  Future<void> getCosts() async {
    costs = await _localDatabase.getCosts();
    sum = 0;
    for (var element in costs) {
      sum += element.amount;
    }
  }

  Future<void> addCost({
    required String title,
    required int amount,
    required DateTime date,
  }) async {
    final newCost = WalletModel(title: title, amount: amount, date: date);
    final id = await _localDatabase.addCosts(newCost);
    costs.add(newCost.copyWith(id: id));
  }

  Future<void> editCost(WalletModel cost) async {
    await _localDatabase.updateCost(cost);
    final currentIndex = costs.indexWhere((c) => c.id == cost.id);
    costs[currentIndex] = cost;
  }

  Future<void> deleteCost(int id) async {
    await _localDatabase.deleteCost(id);
    costs.removeWhere((c) => c.id == id);
  }

  Future<DateTime?> showCalendarAndTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        final DateTime fullDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        return fullDateTime;
      }
    }
    return null;
  }

  Future<DateTime?> showMonthPicker(BuildContext context) async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Oy tanlang',
      cancelText: 'Bekor qilish',
      confirmText: 'Tanlash',
    );

    if (picked != null) {
      return DateTime(picked.year, picked.month);
    }
    return null;
  }

  String getMonthName(DateTime date) {
    List<String> Months = [
      'Yanvar',
      'Fevral',
      'Mart',
      'Aprel',
      'May',
      'Iyun',
      'Iyul',
      'Avgust',
      'Sentyabr',
      'Oktyabr',
      'Noyabr',
      'Dekabr',
    ];
    return '${Months[date.month - 1]}, ${date.year}';
  }
}
