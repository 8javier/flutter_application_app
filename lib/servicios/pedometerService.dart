import 'package:pedometer/pedometer.dart';

class PedometerService {
  late Stream<StepCount> stepCountStream;
  late Stream<PedestrianStatus> pedestrianStatusStream;
  late Stream<Pedometer> pedometerStream;

  int totalSteps = 0;
  String pedestrinStatus = '';

  void startListening() {
    stepCountStream = Pedometer.stepCountStream;
    pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    stepCountStream.listen((StepCount stepCount) {
      totalSteps = stepCount.steps;
    });

    pedestrianStatusStream.listen((PedestrianStatus status) {
      pedestrinStatus = status.status;
    });
  }

  int getTotalSteps() {
    return totalSteps;
  }

  String getTotalDistance() {
    return pedestrinStatus;
  }
}
