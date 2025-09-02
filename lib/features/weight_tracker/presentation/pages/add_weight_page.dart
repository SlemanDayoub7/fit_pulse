import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight/weight_bloc.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight/weight_event.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight_bloc.dart';

class AddWeightPage extends StatefulWidget {
  @override
  _AddWeightPageState createState() => _AddWeightPageState();
}

class _AddWeightPageState extends State<AddWeightPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("أدخل وزنك")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'الوزن (كغ)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                final kg = double.tryParse(_controller.text);
                if (kg != null) {
                  context.read<WeightBloc>().add(AddWeightEntry(kg));
                  Navigator.pop(context);
                }
              },
              child: Text("حفظ"),
            ),
          ],
        ),
      ),
    );
  }
}
