import 'package:app_despesas/models/cost_details.dart';
import 'package:app_despesas/views/cost_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controller.dart';

class Widgets {
  final controller = Get.put(Controller());

  static Widget buildBox(String text, Color? color) {
    return Container(
      width: 160.0,
      height: 160.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Widget buildItemsCostList(Map<String, dynamic> map, String id) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Título: ${map['title']} \n\nValor: ${map['value']}\n\nStatus: ${map['status'] ? 'Pago' : 'Pendente'}'),
                ],
              ),
              const SizedBox(width: 320,),
              IconButton(
                onPressed: () {
                  Controller.deleteCost(id);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        CostDetails cost = CostDetails(
            value: map['value'], status: map['status'], title: map['title']);
        Get.to(CostPage(cost: cost));
      },
    );
  }

  static Widget buildTextField(String text, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
