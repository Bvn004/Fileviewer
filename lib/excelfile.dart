import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:path/path.dart' as path;

class ExcelViewer extends StatefulWidget {
  final List<List<String>> excelData;
  final File fileee;
  ExcelViewer({Key? key, required this.excelData, required this.fileee})
      : super(key: key);

  @override
  State<ExcelViewer> createState() => _ExcelViewerState();
}

class _ExcelViewerState extends State<ExcelViewer> {
  String file_name = 'File name';

  void getpath() {
    file_name = path.basename(widget.fileee.path);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    getpath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          widget.fileee.path.split('/').last,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            onPressed: () {
              print("closing viewer");

              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: widget.excelData.isEmpty
          ? const Center(child: Text('No Data Found'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  decoration: BoxDecoration(color: Colors.white),
                  columns: widget.excelData[0]
                      .map((header) => DataColumn(label: Text(header)))
                      .toList(),
                  rows: widget.excelData
                      .skip(1)
                      .map((row) => DataRow(
                            cells: row
                                .map((cell) => DataCell(Text(cell)))
                                .toList(),
                          ))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
