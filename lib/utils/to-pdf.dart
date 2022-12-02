import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'save-file.dart';

Future<void> createPDF(String text) async {
  PdfDocument document = PdfDocument();
  PdfPage page = document.pages.add();
  // TODO: REMOVE MOCK TEXT
  page.graphics.drawString(
    "text",
    PdfStandardFont(PdfFontFamily.helvetica, 30),
    format: PdfStringFormat(),
  );

  List<int> documentBytes = await document.save();
  document.dispose();

  await saveAndLaunchFile(documentBytes, "Braille.pdf");
}
