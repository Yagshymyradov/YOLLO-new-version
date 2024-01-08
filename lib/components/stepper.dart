import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../utils/theme.dart';

class CurrentStep {
  final int currentStep;

  CurrentStep({required this.currentStep});

  String asValue(BuildContext context) {
    final l10n = context.l10n;
    switch (currentStep) {
      case 1:
        return l10n.created;
      case 2:
        return l10n.called;
      case 3:
        return l10n.confirmed;
      case 4:
        return l10n.accepted;
      case 5:
        return l10n.delivered;
      case 6:
        return l10n.completed;
    }
    return l10n.created;
  }

  Color get textColor {
    switch (currentStep) {
      case 6:
        return const Color(0xFF54B541);
    }
    return Colors.white;
  }
}

class NumberStepper extends StatelessWidget {
  final double width;
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;

  const NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Row(children: _steps()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.l10n.status}: ',
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
            Text(
              CurrentStep(currentStep: curStep).asValue(context),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: CurrentStep(currentStep: curStep).textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color getCircleColor(int i) {
    Color color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep && curStep != 6) {
      color = currentStepColor;
    } else if (6 == curStep) {
      color = const Color(0xFF54B541);
    } else {
      color = Colors.white;
    }
    return color;
  }

  Color getBorderColor(int i) {
    Color color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep && curStep != 6) {
      color = currentStepColor;
    } else if (6 == curStep) {
      color = const Color(0xFF54B541);
    } else {
      color = inactiveColor;
    }

    return color;
  }

  Color? getLineColor(int i) {
    final color = Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    final list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      final circleColor = getCircleColor(i);
      final borderColor = getBorderColor(i);
      final lineColor = getLineColor(i);

      // step circles
      list.add(
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: getInnerElementOfStepper(i),
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(int index) {
    if (index + 1 < curStep) {
      return Container();
    } else if (index + 1 == curStep) {
      return const Center();
    } else {
      return Container();
    }
  }
}
