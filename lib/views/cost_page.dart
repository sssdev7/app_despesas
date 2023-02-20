import 'package:app_despesas/controllers/controller_cost_list.dart';
import 'package:app_despesas/models/cost_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';

class CostPage extends StatelessWidget {
  CostPage({Key? key, this.cost}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final controller = Get.find<ControllerCostsList>();
  final CostDetails? cost;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerCostsList>(
      builder: (_) {

        if(cost !=null){
          titleController.text = cost!.title;
          valueController.text = cost!.value.toString();
        }

        return Scaffold(
          backgroundColor: const Color.fromARGB(122, 128,128,128),
          body: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Widgets.buildBox(
                    cost == null ? 'Novo \ncusto' : 'Atualizar \ncusto',
                    Colors.blueAccent),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Widgets.buildTextField('Título', titleController),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Widgets.buildTextField('Valor', valueController),
                ),
                ElevatedButton(
                  onPressed: () {
                    final double number;
                    try {
                      number = double.parse(valueController.text);
                    } on FormatException {
                      return;
                    }
                    String? title = titleController.text;
                    CostDetails newCost = CostDetails(value: number, status: false, title: title);
                    controller.saveCost(newCost);
                    titleController.clear();
                    valueController.clear();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Adicionar informações', style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
