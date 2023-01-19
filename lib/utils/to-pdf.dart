import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'save-file.dart';

Future<void> createPDF(String text, String filename) async {
  final pdf = pw.Document();
  final symbols = await PdfGoogleFonts.notoSansSymbols2Regular();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Text(text,
            softWrap: true,
            textAlign: pw.TextAlign.justify,
            style: pw.TextStyle(
              fontFallback: [symbols],
              fontSize: 12,
            ));
      }));

  List<int> documentBytes = await pdf.save();

  await saveAndLaunchFile(documentBytes, "$filename.pdf");
}
