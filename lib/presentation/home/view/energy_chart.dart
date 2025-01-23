import 'package:cc_enpal/data/models/data_model.dart';
import 'package:cc_enpal/presentation/home/bloc/home_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnergyChart extends StatefulWidget {
  List<DataModel> data;
  EnergyChart({super.key, required this.data});

  @override
  State<EnergyChart> createState() => _EnergyChartState();
}

class _EnergyChartState extends State<EnergyChart> {
  List<FlSpot> getChartData() {
    return List.generate(widget.data.length, (index) {
      return FlSpot(index.toDouble(), widget.data[index].eValue.toDouble());
    });
  }

  List<String> getTimeLabels() {
    return widget.data.map((data) {
      DateTime dateTime = DateTime.parse(data.timestamp);
      return DateFormat('HH:mm').format(dateTime);
    }).toList();
  }

  LineChartData chartDataConfig(List<String> timeLabels) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              int index = spot.x.toInt(); // Convert x-axis index to integer
              String timeLabel = (index >= 0 && index < timeLabels.length)
                  ? timeLabels[index]
                  : "--:--"; // Fetch corresponding time
              double powerInKW = spot.y / 1000; // Convert Watts to kW

              return LineTooltipItem(
                "$timeLabel\n${powerInKW.toStringAsFixed(2)} kW",
                TextStyle(color: Colors.white, fontSize: 14),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true, // Enables gestures like zoom and pan
      ),
      titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text("${value.toInt()} W",
                    style: TextStyle(fontSize: 8, color: Colors.black));
              },
              reservedSize: 40,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10, // Show every 10th label
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < timeLabels.length) {
                  return Text(timeLabels[index],
                      style: TextStyle(fontSize: 10, color: Colors.black));
                }
                return Container();
              },
              reservedSize: 30,
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false))),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: widget.data.length.toDouble(), // Allow scrolling beyond the dataset
      minY: widget.data
              .map((e) => e.eValue)
              .reduce((a, b) => a < b ? a : b)
              .toDouble() -
          500, // Dynamic minY
      maxY: widget.data
              .map((e) => e.eValue)
              .reduce((a, b) => a > b ? a : b)
              .toDouble() +
          500, // Dynamic maxY
      lineBarsData: [
        LineChartBarData(
          spots: getChartData(),
          isCurved: true,
          curveSmoothness: 0.1,
          color: Colors.orange,
          barWidth: 3,
          aboveBarData: BarAreaData(show: true),
          belowBarData:
              BarAreaData(show: true, color: Colors.orange.withOpacity(0.3)),
          dotData: FlDotData(show: false),
        ),
      ],
      // Enable zooming and panning
      extraLinesData: ExtraLinesData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeLabels = getTimeLabels();
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 2000, // Large width to allow horizontal scrolling
         //   height: MediaQuery.of(context).size.height * 0.5,
            child: LineChart(chartDataConfig(timeLabels)),
          ),
        ),
      );
  }
}
