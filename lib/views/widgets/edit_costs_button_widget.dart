import 'package:flutter/material.dart';

import '../../controllers/wallet_controller.dart';

class EditCostsButtonWidget extends StatefulWidget {
  const EditCostsButtonWidget({super.key});

  @override
  State<EditCostsButtonWidget> createState() => _EditCostsButtonWidgetState();
}

class _EditCostsButtonWidgetState extends State<EditCostsButtonWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final walletController = WalletController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        height: 400,
        color: Color(0xffB2BEB5),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text(
                'Yangi xarajat qushish',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Xarajat nomi...',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Xarajat miqdori...',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onTap: () {},
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Xarajat kuni...',
                ),
              ),
              SizedBox(height: 20),
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
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Qo\'shish',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
