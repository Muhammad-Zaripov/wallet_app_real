import 'package:flutter/material.dart';
import 'package:wallet_app/controllers/wallet_controller.dart';

class AddCostsButtonWidget extends StatefulWidget {
  final VoidCallback onAdded;
  const AddCostsButtonWidget({super.key, required this.onAdded});

  @override
  State<AddCostsButtonWidget> createState() => _AddCostsButtonWidgetState();
}

class _AddCostsButtonWidgetState extends State<AddCostsButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    final _dateController = TextEditingController();
    final walletController = WalletController();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                height: 400,
                color: Color(0xffB2BEB5),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Text(
                        'Yangi xarajat qushish',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
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
                        onTap: () async {
                          final fullDate = await walletController
                              .showCalendarAndTime(context);
                          if (fullDate != null) {
                            _dateController.text = fullDate.toString();
                          }
                        },
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
                            onPressed: () async {
                              await walletController.addCost(
                                title: _titleController.text,
                                amount: int.parse(_amountController.text),
                                date: DateTime.parse(_dateController.text),
                              );
                              await walletController.getCosts();
                              Navigator.pop(context);
                              widget.onAdded();
                            },
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
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xffB2BEB5)),
        child: Icon(Icons.add, color: Colors.blueGrey, size: 25),
      ),
    );
  }
}
