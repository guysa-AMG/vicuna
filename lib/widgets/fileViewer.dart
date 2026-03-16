import "package:cross_file/cross_file.dart";
import 'package:flutter/material.dart';

class FileViewer extends StatefulWidget {

  List<XFile> files;
  Function(XFile)? onDelete;
  FileViewer({super.key, required this.files, this.onDelete});

  @override
  State<FileViewer> createState() => FileViewerState();
}

class FileViewerState extends State<FileViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Opacity(
          opacity: 0.7,
          child: Text(
            "Selected Files",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, letterSpacing: -0.4),
          ),
        ),

        SizedBox(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: super.widget.files.map((file) {
              return Card.outlined(
                child: ListTile(
                  title: Text(file.name),
                  trailing: CloseButton(
                    onPressed: () {
                      if (super.widget.onDelete != null) {
                        super.widget.onDelete!(file);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
