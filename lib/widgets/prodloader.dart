import 'package:flutter/material.dart';

class DeterminedLoadingWidget extends StatefulWidget {
  double? value;
  DeterminedLoadingWidget({super.key, this.value});

  @override
  State<DeterminedLoadingWidget> createState() =>
      DeterminedLoadingWidgetState();
}

class DeterminedLoadingWidgetState extends State<DeterminedLoadingWidget> {
  @override
  Widget build(BuildContext ctx) {
    double? value = (super.widget.value != null)
        ? (super.widget.value!) / 100
        : null;
    return Center(
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                super.widget.value?.toInt().toString() ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 50,
                  letterSpacing: -0.9,
                ),
              ),
              if (super.widget.value != null)
                Text(
                  "%",
                  style: TextStyle(fontSize: 20),
                ),
            ],
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator.adaptive(
              value: value,
              strokeWidth: 30,
              padding: EdgeInsets.all(5),
              strokeCap: StrokeCap.values[1],
              backgroundColor: const Color.fromARGB(74, 37, 37, 37),
              trackGap: 3,
            ),
          ),
        ],
      ),
    );
  }
}
