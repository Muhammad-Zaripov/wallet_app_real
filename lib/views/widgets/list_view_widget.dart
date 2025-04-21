import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/controllers/wallet_controller.dart';

import 'edit_costs_button_widget.dart';

class ListViewWidget extends StatefulWidget {
  final VoidCallback onDeleted;
  const ListViewWidget({super.key, required this.onDeleted});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final walletController = WalletController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ListView.separated(
        separatorBuilder:
            (context, index) => Container(height: 2, color: Color(0xffB2BEB5)),
        itemCount: walletController.costs.length,
        itemBuilder: (context, index) {
          final cost = walletController.costs[index];
          return Dismissible(
            key: ValueKey(cost.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) async {
              await walletController.deleteCost(cost.id!);
              widget.onDeleted();
            },
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return EditCostsButtonWidget();
                  },
                );
              },
              title: Text(
                cost.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffB2BEB5),
                ),
              ),
              subtitle: Text(
                cost.date.toString(),
                style: TextStyle(color: Color(0xffB2BEB5)),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    NumberFormat("#,###").format(cost.amount),
                    style: TextStyle(color: Color(0xffB2BEB5), fontSize: 18),
                  ),
                  Text(
                    'so\'m',
                    style: TextStyle(color: Color(0xffB2BEB5), fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
