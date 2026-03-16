import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EpiChartCard extends StatefulWidget {
  String title;
  EpiChartCard({super.key,required this.title});
  @override
  State<EpiChartCard> createState() => EpicCardState();
}

class EpicCardState extends State<EpiChartCard> {
  @override
  Widget build(BuildContext ctx) {
    return Expanded(
      child: Card.outlined(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(super.widget.title, style: TextStyle(fontSize: 20)),
              SizedBox(width: 200, height: 200, child: SfCartesianChart()),
              Text("50"),
            ],
          ),
        ),
      ),
    );
  }
}
