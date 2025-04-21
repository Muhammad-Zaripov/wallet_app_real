import 'package:flutter/material.dart';
import 'package:wallet_app/controllers/wallet_controller.dart';
import 'package:wallet_app/data/datasources/local_datasources.dart';

class AddLimitCostWidget extends StatefulWidget {
  final VoidCallback onCostAdded;
  const AddLimitCostWidget({super.key, required this.onCostAdded});

  @override
  State<AddLimitCostWidget> createState() => _AddLimitCostWidgetState();
}

class _AddLimitCostWidgetState extends State<AddLimitCostWidget> {
  @override
  Widget build(BuildContext context) {
    final _limitController = TextEditingController();
    final _localDatasource = LocalDatasources();
    final _walletController = WalletController();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: AlertDialog(
        backgroundColor: Color(0xffB2BEB5),
        title: Text(
          'Limitni kiriting',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextFormField(
          controller: _limitController,
          cursorColor: Colors.blueGrey,
          decoration: InputDecoration(
            hintText: 'Limit miqdori...',
            hintStyle: TextStyle(color: Colors.blueGrey),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Yopish',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await _localDatasource.saveLimitCost(
                    limitCost: int.parse(_limitController.text),
                  );
                  Navigator.pop(context);
                  widget.onCostAdded();
                  _limitController.clear();
                  setState(() {
                    _walletController.calculatePercent();
                  });
                },
                child: Text(
                  'Qo\'shish',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
