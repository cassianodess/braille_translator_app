import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'save-file.dart';

Future<void> createPDF(String text, String filename, BuildContext context) async {
  final pdf = pw.Document();
  final symbols = await PdfGoogleFonts.notoSansSymbols2Regular();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Paragraph(
          text: text,
          textAlign: pw.TextAlign.justify,
          style: pw.TextStyle(
            fontFallback: [symbols],
            fontSize: 20,
          ))
      ],
    )
  );

  List<int> documentBytes = await pdf.save();

  await saveAndLaunchFile(documentBytes, "$filename.pdf").then((value) => Navigator.of(context).pop());
}
