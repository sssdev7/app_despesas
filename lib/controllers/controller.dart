import 'package:app_despesas/views/cost_page.dart';
import 'package:get/get.dart';
import '../models/cost_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Controller extends GetxController {

  Controller();
  late List<CostDetails> costList;
  final costCollection = FirebaseFirestore.instance.collection('costs');

  void saveCost (CostDetails newCost){
    costCollection.doc().set({
      'title': newCost.title,
      'value' : newCost.value,
      'status' : newCost.status
    });
  }

  Future<String> sumAllValuesPending () async {
    List<double> allItemsPending = [];
    var result = await costCollection.get();
    for(var doc in result.docs){
      if(doc['status'] == false){
        allItemsPending.add(doc['value']);
      }
    }
    double sum = allItemsPending.fold(0, (accumulated, element) => accumulated + element);
    return sum.toString();
  }

  Future<String> sumAllValuesPaid () async {
    List<double> allItemsPaid = [];
    var result = await costCollection.get();
    for(var doc in result.docs){
      if(doc['status'] == true) {
        allItemsPaid.add(doc['value']);
      }
    }
    double sum = allItemsPaid.fold(0, (accumulated, element) => accumulated + element);
    return sum.toString();
  }

  Future<String> sumAllValues () async {
    List<double> allItems = [];
    var result = await costCollection.get();
    for(var doc in result.docs){
      allItems.add(doc['value']);
    }
    double sum = allItems.fold(0, (accumulated, element) => accumulated + element);
    return sum.toString();
  }

  void showCostPage (CostDetails? cost) async {
    final recCost = await Get.to(CostPage());
    if(recCost != null){
      if(cost != null){
        saveCost(cost);
      }
    }
  }

  void deleteCost (CostDetails c) {
    costCollection.doc().delete();
  }
}