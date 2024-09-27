import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:pdfx/pdfx.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class Pdfviewer extends StatefulWidget {
  final File filee;
  Pdfviewer({super.key, required this.filee});

  @override
  State<Pdfviewer> createState() => _PdfviewerState();
}

class _PdfviewerState extends State<Pdfviewer> {
  late PdfControllerPinch _pdfControllerPinch;

  int tot_page = 0;
  int curr_page = 1;
  String file_path = '';

  String file_name = ' File name ';

  void getpath() {
  

    file_name = path.basename(widget.filee.path);
  }

  @override
  void initState() {
    super.initState();

    getpath();

    _pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openFile(widget.filee.path),
    );
  }

  @override
  void dispose() {
    _pdfControllerPinch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.filee.path.split('/').last,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
      body: ui_pdf(),
    );
  }

  Widget ui_pdf() {
    return Stack(
      children: [
        // PDF Viewer
        PdfViewPinch(
          controller: _pdfControllerPinch,
          onDocumentLoaded: (document) {
            setState(() {
              tot_page = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            setState(() {
              curr_page = page;
            });
          },
        ),

        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total pages: $tot_page",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Page: $curr_page",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
