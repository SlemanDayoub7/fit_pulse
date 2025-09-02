import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/exercise_log.dart';
import 'package:gym_app/features/private_workout/data/data_source/exercise_log_storage.dart';
import 'package:fl_chart/fl_chart.dart';

class ExerciseHistoryPage extends StatefulWidget {
  const ExerciseHistoryPage({super.key});

  @override
  State<ExerciseHistoryPage> createState() => _ExerciseHistoryPageState();
}

class _ExerciseHistoryPageState extends State<ExerciseHistoryPage> {
  List<ExerciseLog> logs = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final loaded = await ExerciseLogStorage.loadLogs();
    setState(() {
      logs = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("سجل التمارين"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: logs.isEmpty
          ? Center(
              child: Text("لا يوجد بيانات",
                  style: TextStyle(fontSize: 18.sp, color: AppColors.gray)),
            )
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (_, i) {
                final log = logs[i];
                final entries = log.entries
                  ..sort((a, b) => a.date.compareTo(b.date));

                return Card(
                  margin: EdgeInsets.all(12.w),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r)),
                  color: AppColors.cardBackground,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(log.exerciseName,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary)),
                        SizedBox(height: 8.h),
                        Text(
                            "المتوسط: ${log.averageWeight.toStringAsFixed(1)} كغ"),
                        Text("الأعلى: ${log.maxWeight.toStringAsFixed(1)} كغ"),
                        Text("الأقل: ${log.minWeight.toStringAsFixed(1)} كغ"),
                        SizedBox(height: 12.h),
                        // PaginatedLineChart(entries: entries),
                        SizedBox(
                            height: 200.h,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                    show: true, drawVerticalLine: false),
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        final int index = value.toInt();
                                        if (index >= entries.length)
                                          return const SizedBox.shrink();
                                        final date = entries[index].date;
                                        final label =
                                            "${date.month}/${date.day}";
                                        return Text(label,
                                            style: TextStyle(fontSize: 10.sp));
                                      },
                                      reservedSize: 28,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      getTitlesWidget: (value, _) => Text(
                                          value.toStringAsFixed(0),
                                          style: TextStyle(fontSize: 10.sp)),
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: true),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: entries.asMap().entries.map((e) {
                                      return FlSpot(
                                          e.key.toDouble(), e.value.weight);
                                    }).toList(),
                                    isCurved: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary.withOpacity(0.4),
                                        AppColors.primary
                                      ],
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primary.withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    barWidth: 3,
                                    dotData: FlDotData(show: true),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class PaginatedLineChart extends StatefulWidget {
  final List<ExerciseLogEntry> entries;

  const PaginatedLineChart({Key? key, required this.entries}) : super(key: key);

  @override
  State<PaginatedLineChart> createState() => _PaginatedLineChartState();
}

class _PaginatedLineChartState extends State<PaginatedLineChart> {
  int startIndex = 0;
  final int pageSize = 5;

  @override
  Widget build(BuildContext context) {
    // تحديد نهاية الصفحة الحالية مع التأكد من عدم تجاوز طول القائمة
    final endIndex = (startIndex + pageSize).clamp(0, widget.entries.length);

    // قائمة النقاط التي سيتم عرضها في الصفحة الحالية
    final currentEntries = widget.entries.sublist(startIndex, endIndex);

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      final int index = value.toInt();
                      if (index < 0 || index >= currentEntries.length) {
                        return const SizedBox.shrink();
                      }
                      final date = currentEntries[index].date;
                      final label = "${date.month}/${date.day}";
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, _) => Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(fontSize: 12),
                    ),
                    interval: 10,
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: currentEntries.asMap().entries.map((e) {
                    return FlSpot(e.key.toDouble(), e.value.weight);
                  }).toList(),
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.4),
                      Colors.blue,
                    ],
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                ),
              ],
              minX: 0,
              maxX: (currentEntries.length - 1).toDouble(),
              minY: widget.entries
                      .map((e) => e.weight)
                      .reduce((a, b) => a < b ? a : b) -
                  5,
              maxY: widget.entries
                      .map((e) => e.weight)
                      .reduce((a, b) => a > b ? a : b) +
                  5,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // أزرار التنقل بين الصفحات
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: startIndex > 0
                  ? () {
                      setState(() {
                        startIndex = (startIndex - pageSize)
                            .clamp(0, widget.entries.length);
                      });
                    }
                  : null,
              child: const Text('السابق'),
            ),
            Text(
              'صفحة ${(startIndex ~/ pageSize) + 1} من ${(widget.entries.length / pageSize).ceil()}',
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: endIndex < widget.entries.length
                  ? () {
                      setState(() {
                        startIndex = (startIndex + pageSize)
                            .clamp(0, widget.entries.length);
                      });
                    }
                  : null,
              child: const Text('التالي'),
            ),
          ],
        ),
      ],
    );
  }
}
