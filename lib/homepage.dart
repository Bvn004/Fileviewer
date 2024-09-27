import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfview/excelfile.dart';
import 'package:pdfview/pdfviewer.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? selectedFile;
  List<List<String>>? excelData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar: AppBar(
        title: const Text("File Preview"),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),*/
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please Select the type of file to view",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(35, 255, 253, 253)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 29, 29, 29)),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(200, 50),
                ),
              ),
              onPressed: () => pdfonpressed(),
              child: Text(
                "PDF Viewer",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 29, 29, 29)),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(200, 50),
                ),
              ),
              onPressed: () {
                pickExcelFile();
              },
              child: Text(
                "Excel File Viewer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pdfonpressed() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Pdfviewer(
            filee: selectedFile!,
          ),
        ),
      );
    }
  }

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      var sheet = excel.sheets[excel.tables.keys.first];
      List<List<String>> data = [];

      if (sheet != null) {
        for (var row in sheet.rows) {
          data.add(row.map((cell) => cell?.value.toString() ?? '').toList());
        }
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ExcelViewer(
            excelData: data,
            fileee: file,
          ),
        ),
      );
    }
  }
}
