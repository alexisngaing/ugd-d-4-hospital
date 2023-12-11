import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:ugd_4_hospital/View/PDF/get_total_invoice.dart';
import 'package:ugd_4_hospital/model/custom_row_invoice.dart';
import 'package:ugd_4_hospital/model/product.dart';
import 'package:ugd_4_hospital/View/PDF/preview_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ugd_4_hospital/View/PDF/item_doc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> createPdf(
    TextEditingController nameController,
    TextEditingController deskripsiController,
    TextEditingController addressController,
    String id,
    BuildContext context,
    List<Product> soldProducts) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1.w,
          ),
        ),
      );
    },
  );

  //peletakan urutan value
  final List<CustomRow> elements = [
    CustomRow("Item Name", "Item Price", "Amount", "Sub Total Product"),
    for (var product in soldProducts)
      CustomRow(
        product.name,
        product.price.toStringAsFixed(2),
        product.amount.toString(),
        (product.price * product.amount).toStringAsFixed(2),
      ),
    CustomRow(
      "Total",
      "",
      "",
      "Rp ${getSubTotal(soldProducts)}",
    ),
  ];

  pw.Widget table = itemColumn(elements);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                pw.Container(
                    margin: pw.EdgeInsets.symmetric(
                        horizontal: 2.h, vertical: 0.h)),
                personalDataFromInput(
                    nameController, deskripsiController, addressController),
                pw.SizedBox(height: 1.h),
                barcodeGaris(id),
                pw.SizedBox(height: 1.h),
                contentOfInvoice(table),
                barcodeKotak(id),
                pw.SizedBox(height: 1.h),
              ])),
        ];
      },
      //footer
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate));
      },
    ),
  );

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc)));
}

pw.Header headerPDF() {
  return pw.Header(
      margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.rectangle,
        gradient: pw.LinearGradient(
          colors: [
            PdfColor.fromHex('#FCDF8A'),
            PdfColor.fromHex('#F38381'),
          ],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          '-Invoice-',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ));
}

pw.Padding personalDataFromInput(
  TextEditingController nameController,
  TextEditingController deskripsiController,
  TextEditingController addressController,
) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                'Name',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                nameController.text,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                'Deskripsi',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                deskripsiController.text,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                'Address',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              child: pw.Text(
                addressController.text,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(imageInvoice, height: 30.h, width: 30.w),
        pw.Expanded(
          child: pw.Container(
            height: 10.h,
            decoration: const pw.BoxDecoration(
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                color: PdfColors.amberAccent),
            padding: const pw.EdgeInsets.only(
                left: 40, top: 10, bottom: 10, right: 40),
            alignment: pw.Alignment.centerLeft,
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                pw.Text('Awesome Product',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.Text('Anggrek Strreet 12',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.SizedBox(height: 1.h),
                pw.Text('Jakrta 511',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.SizedBox(height: 1.h),
                pw.SizedBox(height: 1.h),
                pw.Text('Contact us',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.SizedBox(height: 1.h),
                pw.Text('Phone Number',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.Text('0230231321',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.Text('Email',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
                pw.Text('AsikAsik@gmail.com',
                    style: pw.TextStyle(
                        fontSize: 10.sp, color: PdfColors.blue800)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table) {
  final List<pw.Widget> content = [
    pw.Text("Foto Pembeli"),
    pw.SizedBox(height: 1.h),
    table,
    pw.Text("Makasih udah belanja tengs yah bro/sis"),
    pw.SizedBox(height: 1.h),
    pw.Text("Terima kasih aja lah ya, sampe next time. "),
    pw.SizedBox(height: 1.h),
    pw.Text("Kind regards"),
    pw.SizedBox(height: 1.h),
    pw.Text("Kelompok 4"),
  ];

  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Column(children: content),
  );
}

pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 15.w,
        height: 5.h,
      ),
    ),
  );
}

pw.Padding barcodeGaris(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: id,
        width: 10.w,
        height: 5.h,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue)));
