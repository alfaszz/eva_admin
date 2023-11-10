import 'package:adminapp/creditPage.dart';
import 'package:adminapp/debitPage.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
          backgroundColor: Colors.blue[900],
          bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
            Tab(
              text: 'Debit',
            ),
            Tab(
              text: 'Credit',
            )
          ]),


        ),

        body: TabBarView(children: [
         Debit(),
          Credit(),
        ]),
      ),
    );
  }
}
