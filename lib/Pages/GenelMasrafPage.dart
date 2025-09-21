import 'package:HasatDefteri/Pages/tarlaMasraf.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../constObjects.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

Colorss color = Colorss();

class ExpenseAnalyticsPage extends StatefulWidget {
  @override
  _ExpenseAnalyticsPageState createState() => _ExpenseAnalyticsPageState();
}

class _ExpenseAnalyticsPageState extends State<ExpenseAnalyticsPage> {
  final Map<String, Color> categoryColors = {
    "Yakıt": Colors.green.shade900,
    "İlaç": Colors.red.shade900,
    "Gübre": Colors.yellow.shade700,
    "Tohum": Colors.brown.shade900,
    "Sulama": Colors.blue.shade400,
    "İşçi": Colors.purple.shade900,
    "Hasat": Colors.orange.shade700,
    "Diğer": Colors.grey.shade700,
  };

  Map<String, double> dataMap = {
    "Yakıt": 12.5,
    "İlaç": 12.5,
    "Gübre": 12.5,
    "Tohum": 12.5,
    "Sulama": 12.5,
    "İşçi": 12.5,
    "Hasat": 12.5,
    "Diğer": 12.5,
  };

  // Verilere göre dinamik renk listesi oluşturma
  List<Color> getColorList() {
    return dataMap.keys.map((category) {
      return categoryColors[category] ?? Colors.grey; // Default renk
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final amountFormat = NumberFormat("#,##0.00", "tr_TR");
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: HexColor(color.cGreen2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(9),
                    ),
                    border: Border.all(color: HexColor(color.cYellow3), width: 1.5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Toplam Masraf: " +
                          "${amountFormat.format(985500)}" +
                          " TL",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                // Pasta dilimi grafik gösterimi
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: HexColor(color.cGreen2)),
                    ),
                    child: pie.PieChart(
                      dataMap: dataMap,
                      colorList: getColorList(),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.2,
                    progressColor: Colors.green.shade900,
                    backgroundColor: Colors.green.shade900.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: const Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.5,
                    progressColor: Colors.red.shade900,
                    backgroundColor: Colors.red.shade900.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.5,
                    progressColor: Colors.yellow.shade700,
                    backgroundColor: Colors.yellow.shade700.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.3,
                    progressColor: Colors.brown.shade700,
                    backgroundColor: Colors.brown.shade700.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.5,
                    progressColor: Colors.blue.shade400,
                    backgroundColor: Colors.blue.shade400.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.5,
                    progressColor: Colors.purple.shade700,
                    backgroundColor:
                        Colors.purpleAccent.shade700.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.5,
                    progressColor: Colors.orange.shade700,
                    backgroundColor: Colors.orange.shade700.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  Mazot: 1250₺",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 25,
                    percent: 0.5,
                    progressColor: Colors.grey.shade700,
                    backgroundColor: Colors.grey.shade700.withOpacity(0.2),
                    barRadius: Radius.circular(5),
                    center: Text(
                      "%50",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
