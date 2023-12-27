import 'package:flutter/material.dart';

import 'all_text.dart';

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
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 15.0,
            right: 15.0,
            bottom: 10
    ),
          child: Row(
            children: _steps(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AllText(text: 'Status : ', fontWeight: FontWeight.w700, fontSize: 14,),
            if (curStep == 1) const AllText(text: 'Döredildi', fontWeight: FontWeight.w700, fontSize: 14,) else curStep == 2 ? const AllText(text: 'Jaň edildi', fontWeight: FontWeight.w700, fontSize: 14,)
                : curStep == 3 ? const AllText(text: 'Tassyklandy', fontWeight: FontWeight.w700, fontSize: 14,)
                : curStep == 4 ? const AllText(text: 'Kabul edildi', fontWeight: FontWeight.w700, fontSize: 14,)
                : curStep == 5 ? const AllText(text: 'Ugradyldy', fontWeight: FontWeight.w700, fontSize: 14,)
                : curStep == 6 ? const AllText(
                  text: 'Tamamlandy', fontWeight: FontWeight.w700, fontSize: 14,
                  color: Color(0xFF54B541),
                ): Container()
          ],
        )
      ],
    );
  }

  Color getCircleColor(int i) {
    Color color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep && curStep != 6 ) {
      color = currentStepColor;
    } else if(6 == curStep){
      color = const Color(0xFF54B541);
    }else {
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
    } else if(6 == curStep){
      color = const Color(0xFF54B541);
    }else {
      color = inactiveColor;
    }

    return color;
  }

  Color? getLineColor(int i) {
    var color =
        // curStep > i + 1 ? Colors.blue.withOpacity(0.4) :
        Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: borderColor,
              width: 1.0,
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
      // Icon(
        // Icons.check,
        // color: Colors.white,
        // size: 16.0,
      // );
    } else if (index + 1 == curStep) {
      return const Center(
        // child: Text(
        //   '$curStep',
        //   style: const TextStyle(
        //     color: Colors.blue,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'Roboto',
        //   ),
        // ),
      );
    } else {
      return Container();
    }
  }
}
