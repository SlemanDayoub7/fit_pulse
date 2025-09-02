import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepTrackerPage extends StatefulWidget {
  @override
  _StepTrackerPageState createState() => _StepTrackerPageState();
}

class _StepTrackerPageState extends State<StepTrackerPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  int _steps = 0;
  String _status = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPedometer();
  }

  void initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onStepCountError(error) {
    print('Step Count Error: $error');
  }

  void onPedestrianStatusError(error) {
    print('Pedestrian Status Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Steps taken:', style: TextStyle(fontSize: 24)),
            Text('$_steps',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Text('Status:', style: TextStyle(fontSize: 24)),
            Text('$_status', style: TextStyle(fontSize: 32)),
          ],
        ),
      ),
    );
  }
}
