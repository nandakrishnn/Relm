import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl; // Assuming you retrieve the PDF URL from your database

  PDFViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  Future<void> _initPdf() async {
    final filename = widget.pdfUrl.split('/').last;
    final request = await http.get(Uri.parse(widget.pdfUrl));
    final bytes = request.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    if (mounted) {
      setState(() {
        _localFilePath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PDF Viewer'),
      // ),
      body: _localFilePath != null
          ? PDFView(
              filePath: _localFilePath!,
              onError: (error) {
                print('PDFView Error: $error');
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
