import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/src/resource/model/bill_chart.dart';
import 'package:safe_food/src/resource/provider/bill_provider.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [AppTheme.analyse1, AppTheme.analyse2];

  bool showIncome = false;

  @override
  void initState() {
    Provider.of<BillProvider>(context, listen: false).getListBillCount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final billProvider = Provider.of<BillProvider>(context);
    return billProvider.isLoad
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.4,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 12,
                  ),
                  child: LineChart(
                    showIncome ? incomeData() : mainData(),
                  ),
                ),
              ),
              SizedBox(
                width: 65,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showIncome = !showIncome;
                    });
                  },
                  child: Text(
                    'revenue',
                    style: TextStyle(
                      fontSize: 14,
                      color: showIncome
                          ? Colors.black.withOpacity(0.5)
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  List<FlSpot> drawpoint() {
    final billProvider = Provider.of<BillProvider>(context);
    final List<BillChart> listBillCount = billProvider.listBillCount;
    listBillCount.sort((a, b) => a.date!.compareTo(b.date!));
    List<FlSpot> points = [];
    for (BillChart order in listBillCount) {
      points.add(FlSpot(order.date!.day.toDouble(), order.count!.toDouble()));
    }
    return points;
  }

  double getMaxX() {
    final billProvider = Provider.of<BillProvider>(context);
    final listBillCount = billProvider.listBillCount as List<dynamic>;
    listBillCount.sort((a, b) => a.date!.compareTo(b.date!));
    return listBillCount[listBillCount.length - 1].date!.day.toDouble();
  }

  List<FlSpot> drawpointIncome() {
    final billProvider = Provider.of<BillProvider>(context);
    final List<BillChart> listBillCount = billProvider.listBillCount;
    listBillCount.sort((a, b) => a.date!.compareTo(b.date!));
    List<FlSpot> points = [];
    for (BillChart order in listBillCount) {
      points.add(FlSpot(order.date!.day.toDouble(),
          double.parse(order.totalPayment!) / 1000000));
    }
    return points;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime dateTime = DateTime.now(); // Đây là ngày tháng hiện tại
    int month = dateTime.month;
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    switch (value.toInt()) {
      case 1:
        text = Text('1/$month', style: style);
        break;
      case 5:
        text = Text('5/$month', style: style);
        break;
      case 10:
        text = Text('10/$month', style: style);
        break;
      case 15:
        text = Text('15/$month', style: style);
        break;
      case 20:
        text = Text('20/$month', style: style);
        break;
      case 25:
        text = Text('25/$month', style: style);
        break;
      case 30:
        text = Text('30/$month', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgetsIncome(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1M';
        break;
      case 3:
        text = '3M';
        break;
      case 5:
        text = '5M';
        break;
      case 7:
        text = '7M';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: getMaxX(),
      minY: 0,
      maxY: 20,
      lineBarsData: [
        LineChartBarData(
          spots: drawpoint(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData incomeData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgetsIncome,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: getMaxX(),
      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: drawpointIncome(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
