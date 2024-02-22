import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewAdmin extends StatefulWidget {
  final String filePath;
  const PdfViewAdmin({Key? key, required this.filePath}) : super(key: key);

  @override
  State<PdfViewAdmin> createState() => _PdfViewAdminState();
}

class _PdfViewAdminState extends State<PdfViewAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(filePath:widget.filePath),
    );
  }
}