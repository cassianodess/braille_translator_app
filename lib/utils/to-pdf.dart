import 'package:braille_translator/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'save-file.dart';
import 'package:path_provider/path_provider.dart';
import "dart:math" as math;



Future<void> createPDF(String text, String filename, BuildContext context, { bool positive = true} ) async {
  final pdf = pw.Document();
  final symbols = await PdfGoogleFonts.notoSansSymbols2Regular();

  pdf.addPage(
    pw.MultiPage(
      textDirection: positive ? pw.TextDirection.ltr : pw.TextDirection.rtl,
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Transform(
          transform: Matrix4.rotationY(positive ? 0 : math.pi),
          adjustLayout: true,
          child: pw.Paragraph(
            text: text,
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(
              fontFallback: [symbols],
              fontSize: 20,
            )
          )
        ),
      ],
    )
  );

  List<int> documentBytes = await pdf.save();

  await saveAndLaunchFile(documentBytes, "$filename.pdf")
  .then((value) async {
    String path = (await getExternalStorageDirectory())!.path;

    Navigator.of(context).pop();
    showToast(context, "Arquivo salvo em: ${path}/${filename}.pdf", duration: Duration(minutes: 1));


  }
  );
}
