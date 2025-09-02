// domain/entities/day_of_week.dart
enum DayOfWeek {
  saturday(1, 'السبت'),
  sunday(2, 'الأحد'),
  monday(3, 'الاثنين'),
  tuesday(4, 'الثلاثاء'),
  wednesday(5, 'الأربعاء'),
  thursday(6, 'الخميس'),
  friday(7, 'الجمعة');

  final int number;
  final String nameAr;

  const DayOfWeek(this.number, this.nameAr);

  static DayOfWeek? fromNumber(int number) {
    return DayOfWeek.values.firstWhere(
      (day) => day.number == number,
    );
  }
}
