import 'dart:io';


import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/utils/file_handler.dart';
import 'package:vendor/utils/type_converter.dart';

class Invoice {
  final String invoiceNumber;
  final DateTime invoiceDate;
  final String companyName;
  final String companyAddress;
  final String customerName;
  final String customerAddress;
  final double deliveryCharge;
  final int platformFee;
  final List<Products> items;

  Invoice({
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.companyName,
    required this.companyAddress,
    required this.customerName,
    required this.customerAddress,
    required this.deliveryCharge,
    required this.platformFee,
    required this.items,
  });

  static Future<File> generate(Invoice invoice) async {
    final regularFont = await PdfGoogleFonts.robotoRegular();
    final mediumFont = await PdfGoogleFonts.robotoMedium();
    final boldFont = await PdfGoogleFonts.robotoBold();
    var regularTextStyle = pw.TextStyle(font: regularFont);
    var mediumTextStyle = pw.TextStyle(font: mediumFont);
    var boldTextStyle = pw.TextStyle(font: boldFont);
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tax Invoice', textScaleFactor: 2, style: boldTextStyle),
                  pw.PdfLogo(),
                ],
              ),
            ),
            pw.Paragraph(
                text: 'Invoice Number: ${invoice.invoiceNumber}',
                style: mediumTextStyle),
            pw.Paragraph(
                text: 'Invoice Date: ${invoice.invoiceDate}',
                style: mediumTextStyle),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              oddCellStyle: regularTextStyle,
              cellStyle: regularTextStyle,
              headerStyle: mediumTextStyle,
              context: context,
              data: <List<String>>[
                <String>['Company Name', invoice.companyName],
                <String>['Company Address', invoice.companyAddress],
                <String>['GSTIN', '19AAGTBFSFO3'],
                <String>['Customer Name', invoice.customerName],
                <String>['Customer Address', invoice.customerAddress],
              ],
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headerStyle: mediumTextStyle,
              oddCellStyle: regularTextStyle,
              cellStyle: regularTextStyle,
              context: context,
              // headerCount: 6,
              data: <List<String>>[
                <String>[
                  'Title',
                  'Qty',
                  'Gross\nAmount₹',
                  'Discount₹',
                  'Taxable\nValue₹',
                  'IGST\n₹',
                  'Total₹'
                ],
                ...invoice.items.map((item) => [
                      item.productName ?? '',
                      item.qty.toString(),
                      item.mrp.toString(),
                      (toDouble(item.mrp!) - toDouble(item.offerPrice!))
                          .toString(),
                      (toDouble(item.offerPrice!) /
                              (1 + (item.gst ?? 0) / 100)) //Taxable Amount
                          .toStringAsFixed(2),
                      (((item.gst ?? 0) * toDouble(item.offerPrice)) /
                              100) //GST AMOUNT
                          .toString(),
                      ((item.qty ?? 0) * num.parse(item.offerPrice!)) // Total
                          .toString(),
                    ]),
                if (invoice.deliveryCharge != 0)
                  <String>[
                    'Delivery Charge',
                    '1',
                    invoice.deliveryCharge.toString(),
                    '0',
                    '0',
                    '0',
                    invoice.deliveryCharge.toString()
                  ],
                if (invoice.platformFee != 0)
                  <String>[
                    'Platform Fee',
                    '1',
                    invoice.platformFee.toString(),
                    '0',
                    '0',
                    '0',
                    invoice.platformFee.toString()
                  ],
                <String>[
                  'Total',
                  invoice.getQtySum().toString(),
                  invoice.getGrossTotal().toString(),
                  invoice.getDiscountSum().toString(),
                  invoice.getTaxableValueSum().toStringAsFixed(2),
                  invoice.getTaxSum().toString(),
                  invoice.getTotal().toString(),
                ],
              ],
            ),
          ];
        },
      ),
    );
    return FileHandler.saveDocument(name: 'my_invoice.pdf', data: pdf);
  }

  double getGrossTotal() {
    return platformFee+ deliveryCharge+ items.fold(
        0, (sum, item) => sum + item.qty! * num.parse(item.mrp!));
  }

  double getTotal() {
    return platformFee+ deliveryCharge+ items.fold(
        0, (sum, item) => sum + item.qty! * num.parse(item.offerPrice!));
  }

  int getQtySum() {
    return items.fold(0, (sum, item) => sum + item.qty!);
  }

  double getDiscountSum() {
    return items.fold(0,
        (sum, item) => sum + (toDouble(item.mrp) - toDouble(item.offerPrice!)));
  }

  double getTaxableValueSum() {
    return items.fold(
        0,
        (sum, item) =>
            sum + (toDouble(item.offerPrice!) /
                (1 + (item.gst ?? 0) / 100)) );
  }

  double getTaxSum() {
    return items.fold(
        0,
            (sum, item) =>
        sum + (((item.gst ?? 0) * toDouble(item.offerPrice)) / 100));
  }


}

class InvoiceItem {
  final String description;
  final int quantity;
  final double unitPrice;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });
}

class PdfLogo extends pw.StatelessWidget {
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      height: 50,
      width: 50,
      child: pw.FittedBox(
        child: pw.Image(
          pw.MemoryImage(
            // Replace with your logo image bytes
            File('assets/png/app_logo.png').readAsBytesSync(),
          ),
        ),
      ),
    );
  }
}
