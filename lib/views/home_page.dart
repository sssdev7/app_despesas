import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import '../controllers/controller.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(Controller());
  String totalPaid = '';
  String totalPending = '';
  String totalCost = '';

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      init: Controller(),
      builder: (_) {
        _.sumAllValuesPaid().then((value) => totalPaid = value);
        _.sumAllValuesPending().then((value) => totalPending = value);
        _.sumAllValues().then((value) => totalCost = value);

        return Scaffold(
          backgroundColor:const Color.fromARGB(122, 128,128,128),
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: const Text('Monitoramento de custos'),
          ),
          body: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _.showCostPage(null);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: const[
                              Icon(Icons.add),
                              SizedBox(width: 10.0),
                              Text('Add novo custo', style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      width: 500,
                      child: FirestoreListView<Map<String, dynamic>>(
                        query: Controller.costCollection,
                        itemBuilder: (context, snapshot) {
                          Map<String, dynamic> map = snapshot.data();
                          String id = snapshot.id;
                          return Widgets.buildItemsCostList(map, id);
                        }
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Widgets.buildBox('Total pago: \n$totalPaid', Colors.green),
                    ),
                    Widgets.buildBox('Total pendente: \n$totalPending', Colors.redAccent),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Widgets.buildBox('Custos totais: \n$totalCost', Colors.blueAccent),
                    )
                  ],
                ),
              ),
            ],
          )
        );
      }
    );
  }
}
