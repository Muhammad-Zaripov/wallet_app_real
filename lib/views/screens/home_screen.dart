import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wallet_app/controllers/wallet_controller.dart';
import 'package:wallet_app/data/datasources/local_datasources.dart';
import 'package:wallet_app/views/widgets/add_costs_button_widget.dart';
import 'package:wallet_app/views/widgets/add_limit_cost_widget.dart';
import 'package:wallet_app/views/widgets/list_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _walletController = WalletController();
  final _localDatasource = LocalDatasources();

  DateTime _selectedDate = DateTime.now();

  void _selectMonth() async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _loadData() async {
    final newLimitCost = await _localDatasource.getLimitCost();
    setState(() {
      _walletController.limitCost = newLimitCost;
    });
  }

  @override
  void initState() {
    super.initState();
    _walletController.getCosts().then((result) {
      _loadData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F1EE),
      appBar: AppBar(
        backgroundColor: Color(0xffF4F1EE),
        leading: IconButton(
          onPressed: () {
            _selectedDate = DateTime(
              _selectedDate.year,
              _selectedDate.month - 1,
            );
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey),
        ),
        title: TextButton(
          onPressed: _selectMonth,
          child: Text(
            _walletController.getMonthName(_selectedDate),
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              _selectedDate = DateTime(
                _selectedDate.year,
                _selectedDate.month + 1,
              );
              setState(() {});
            },
            icon: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.8),
              child: Text(
                NumberFormat('#,###').format(_walletController.sum),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffB2BEB5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 25,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (contex) {
                              return AddLimitCostWidget(
                                onCostAdded: () {
                                  setState(() {
                                    _loadData();
                                  });
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'Hisob:  ${NumberFormat('#,###').format(_walletController.limitCost)} so\'m',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: LinearPercentIndicator(
                          animation: true,
                          width: 310,
                          lineHeight: 20.0,
                          percent: 0.6,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.blueGrey,
                          barRadius: const Radius.circular(16),
                          trailing: Text(
                            "${_walletController.calculatePercent()}%",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListViewWidget(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddCostsButtonWidget(
        onAdded: () {
          setState(() {});
        },
      ),
    );
  }
}
