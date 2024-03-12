import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl; // Assuming you retrieve the PDF URL from your database

  PDFViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? _localFilePath;
  late PDFViewController _pdfViewController;
  int savedPage = 0;
  bool isResuming = false;

  @override
  void initState() {
    super.initState();
    initPdf();
  }

Future<void> initPdf() async {
  final prefs = await SharedPreferences.getInstance();
  final filename = widget.pdfUrl.split('/').last;
  final file = File(widget.pdfUrl); // Use the File constructor with the file path
  
  try {
    final bytes = await file.readAsBytes();
    final dir = await getApplicationDocumentsDirectory();
    final localFile = File('${dir.path}/$filename');
    await localFile.writeAsBytes(bytes);
    setState(() {
      _localFilePath = localFile.path;
    });

    savedPage = prefs.getInt('lastReadPage') ?? 0;

    // Show dialog to ask the user to resume or start from beginning
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Resume Reading?'),
        content: const Text('Do you want to resume reading from where you left off?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                isResuming = true;
              });
              Navigator.of(context).pop();
              _pdfViewController.setPage(savedPage);
            },
            child: const Text('Resume'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Start from Beginning'),
          ),
        ],
      ),
    );
  } catch (error) {
    print('Error downloading PDF: $error');
  }
}

  Future<void> saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastReadPage', page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _localFilePath != null
            ? PDFView(
                filePath: _localFilePath!,
                onError: (error) {
                  print('PDFView Error: $error');
                },
                onViewCreated: (PDFViewController controller) {
                  _pdfViewController = controller;
                  if (isResuming) {
                    _pdfViewController.setPage(savedPage);
                  }
                },
                onPageChanged: (page, _) {
                  saveCurrentPage(page!);
                },
                onPageError: (page, error) {
                  print('PDFView Error - Page $page: $error');
                },
              )
            : Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Lottie.network(
                          'https://lottie.host/6e1e402d-c68d-44a0-8409-998b62bb56ec/tsXeskJTiP.json',
                           height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          ))),
            ));
  }
}
