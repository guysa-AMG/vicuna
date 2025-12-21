import 'package:flutter/material.dart';
import 'package:vicuna/model/report.dart';
import 'package:vicuna/services/misc/constants.dart';

class ReportCard extends StatefulWidget {

  MedicalReport report;

  ReportCard({super.key, required this.report});
  @override
  State<ReportCard> createState() => ReportCardState();
}

class ReportCardState extends State<ReportCard> {
  Map<String, Color> criticality = {
    "Critical": Colors.red,
    "High": Colors.deepOrange,
    "Moderate": Colors.amber,
    "Low": Colors.lightGreenAccent,
  };
  @override
  Widget build(BuildContext context) {
    MedicalReport report = super.widget.report;
    TextStyle header = TextStyle(
      fontSize: 18,
      letterSpacing: -0.8,
      fontWeight: FontWeight.w600,
    );
    TextStyle value = TextStyle(
      fontSize: 14,
      letterSpacing: 0.6,
      leadingDistribution: TextLeadingDistribution.proportional,
      fontWeight: FontWeight.w500,
    );
    return Card.outlined(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: criticality[report.criticality]!),
        borderRadius: BorderRadiusGeometry.all(VicunaVar.borderRadius),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 30,
          children: [
            SizedBox(height: 10),
            Text(report.situationTitle, style: header),
            Container(
              padding: EdgeInsets.all(5),
              width: double.maxFinite,
              color: criticality[report.criticality],
              child: Wrap(
                children: [
                  Text("Criticality: "),
                  Text(
                    report.criticality,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
            ),

            Text("Brief Explanation", style: header),
            Text(report.explanation, style: value),
            Text("Warning Signs", style: header),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: report.warningSigns
                  .map((signs) => Text("*  " + signs + "\n", style: value))
                  .toList(),
            ),
            Text("findings", style: header),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: report.keyFindings
                  .map(
                    (findings) => Text("*  " + findings + "\n", style: value),
                  )
                  .toList(),
            ),

            Text("next steps", style: header),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: report.nextSteps
                  .map((steps) => Text("*  " + steps + "\n", style: value))
                  .toList(),
            ),

            report.followUpQuestion != null
                ? Text(report.followUpQuestion!)
                : SizedBox(),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
