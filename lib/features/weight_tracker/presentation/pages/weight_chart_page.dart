import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/weight_tracker/domain/entities/weight_entry.dart';

class WeightChartPage extends StatefulWidget {
  @override
  _WeightChartPageState createState() => _WeightChartPageState();
}

class _WeightChartPageState extends State<WeightChartPage> {
  String _selectedPeriod = '5days'; // الفترة المحددة افتراضيًا
  DateTime _selectedDate = DateTime.now(); // التاريخ المحدد افتراضيًا
  List<WeightEntry> _entries = []; // البيانات
  List<FlSpot> _spots = []; // النقاط على المخطط

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // بيانات وهمية للتجربة
    final now = DateTime.now();
    _entries = List.generate(365 * 3, (i) {
      // بيانات لمدة ثلاث سنوات
      return WeightEntry(
        date: now.subtract(Duration(days: 365 * 3 - i - 1)), // تصحيح التاريخ
        kg: 70.0 + i * 0.01 - (i % 2) * 0.05, // تعديل الزيادة في الوزن
      );
    });

    _filterData();
  }

  void _filterData() {
    List<WeightEntry> filteredEntries = [];

    if (_selectedPeriod == 'week') {
      filteredEntries = _entries.where((entry) {
        return entry.date.isAfter(_selectedDate.subtract(Duration(days: 7))) &&
            entry.date.isBefore(_selectedDate.add(Duration(days: 1)));
      }).toList();
    } else if (_selectedPeriod == 'month') {
      filteredEntries = _entries.where((entry) {
        return entry.date.month == _selectedDate.month &&
            entry.date.year == _selectedDate.year;
      }).toList();
    } else if (_selectedPeriod == 'year') {
      filteredEntries = _entries.where((entry) {
        return entry.date.year == _selectedDate.year;
      }).toList();
    } else if (_selectedPeriod == '5days') {
      // فترة 5 أيام
      filteredEntries = _entries.where((entry) {
        return entry.date.isAfter(_selectedDate) &&
            entry.date.isBefore(_selectedDate.add(Duration(days: 5)));
      }).toList();
    }

    _spots = filteredEntries
        .map((e) => FlSpot(
              e.date.millisecondsSinceEpoch.toDouble(),
              e.kg,
            ))
        .toList();

    setState(() {}); // تحديث الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "مخطط الوزن",
          style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPeriod == 'week'
                        ? AppColors.primary
                        : AppColors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedPeriod = 'week';
                    });
                    _filterData();
                  },
                  child:
                      Text('أسبوع', style: TextStyle(color: AppColors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPeriod == 'month'
                        ? AppColors.primary
                        : AppColors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedPeriod = 'month';
                    });
                    _filterData();
                  },
                  child: Text('شهر', style: TextStyle(color: AppColors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPeriod == 'year'
                        ? AppColors.primary
                        : AppColors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedPeriod = 'year';
                    });
                    _filterData();
                  },
                  child: Text('سنة', style: TextStyle(color: AppColors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPeriod == '5days'
                        ? AppColors.primary
                        : AppColors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedPeriod = '5days';
                    });
                    _filterData();
                  },
                  child:
                      Text('5 أيام', style: TextStyle(color: AppColors.white)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                      _filterData();
                    }
                  },
                  child: Text('اختر تاريخ',
                      style: TextStyle(color: AppColors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: _spots,
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 5, // زيادة عرض الخط
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                color: AppColors.white,
                                strokeColor: AppColors.primary,
                                strokeWidth: 3, // زيادة سمك الحدود
                                radius: 5, // زيادة حجم النقاط
                              );
                            },
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: _getInterval(),
                            getTitlesWidget: (value, meta) {
                              final date = DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt());
                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  _getDateFormat(date),
                                  style: TextStyle(
                                    fontSize: 14.sp, // زيادة حجم النص
                                    color: AppColors.mutedText,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 40.w, // زيادة المساحة المخصصة للنص
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1) + ' كجم',
                                style: TextStyle(
                                  fontSize: 14.sp, // زيادة حجم النص
                                  color: AppColors.mutedText,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false, // إخفاء المحور العلوي
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false, // إخفاء المحور الأيمن
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false, // إخفاء الخطوط الشبكية الرأسية
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColors.border,
                            strokeWidth: 1, // زيادة سمك الخطوط الشبكية
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors
                                .transparent, // إخفاء الخطوط الشبكية الرأسية
                            strokeWidth: 0.5,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: AppColors.border,
                            width: 1), // زيادة سمك الحدود
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  double _getInterval() {
    if (_selectedPeriod == 'week') {
      return Duration(days: 1).inMilliseconds.toDouble();
    } else if (_selectedPeriod == 'month') {
      return Duration(days: 3).inMilliseconds.toDouble(); // كل ثلاثة أيام
    } else if (_selectedPeriod == 'year') {
      return Duration(days: 30).inMilliseconds.toDouble(); // كل شهر
    } else if (_selectedPeriod == '5days') {
      return Duration(days: 1).inMilliseconds.toDouble(); // كل يوم
    }
    return 0;
  }

  String _getDateFormat(DateTime date) {
    if (_selectedPeriod == 'week') {
      return DateFormat('dd/MM').format(date);
    } else if (_selectedPeriod == 'month') {
      return DateFormat('dd/MM').format(date);
    } else if (_selectedPeriod == 'year') {
      return DateFormat('MM/yyyy').format(date);
    } else if (_selectedPeriod == '5days') {
      return DateFormat('dd/MM').format(date);
    }
    return '';
  }
}
