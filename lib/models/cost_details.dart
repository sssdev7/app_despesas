
class CostDetails {
  final double value;
  final String title;
  final bool status;

  CostDetails(
      {required this.value, required this.status, required this.title});


  Map<String, dynamic> toMap () {
    return {
      'title' : title,
      'value' : value,
      'status' : status,
    };
  }
}