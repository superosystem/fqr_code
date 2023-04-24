import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;

  void exportCatalogToPDF() async {
    var dateNow = DateFormat('EEEE, dd-MM-yyyy – kk:mm:ss').format(DateTime.now());
    final openSans = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/OpenSans-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/OpenSans-Bold.ttf")),
      italic: Font.ttf(await rootBundle.load("assets/OpenSans-Italic.ttf")),
      boldItalic:
          Font.ttf(await rootBundle.load("assets/OpenSans-BoldItalic.ttf")),
    );
    final pdf = pw.Document(theme: openSans);

    // reset before new export
    allProducts([]);
    // Fetch data from fireStore
    var getData = await db.collection("products").get();
    // and fill into allProducts variable
    for (var element in getData.docs) {
      allProducts.add(ProductModel.fromJson(element.data()));
    }

    // Setup page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // all data
          List<pw.TableRow> allDataProducts = List.generate(
            allProducts.length,
            (index) {
              ProductModel product = allProducts[index];

              return pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.Padding(
                    padding: const EdgeInsets.all(10),
                    child: pw.Text(
                      "${index + 1}",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const EdgeInsets.all(10),
                    child: pw.Text(
                      product.code,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const EdgeInsets.all(10),
                    child: pw.Text(
                      product.name,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const EdgeInsets.all(10),
                    child: pw.Text(
                      "${product.qty}",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const EdgeInsets.all(10),
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex("#000000"),
                      barcode: pw.Barcode.qrCode(),
                      data: product.code,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              );
            },
          );

          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text(
                  "PRODUCTS CATALOG",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  "Date : $dateNow",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromHex("#000000"),
                  width: 2,
                ),
                children: [
                  // Table Header
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Padding(
                        padding: const EdgeInsets.all(10),
                        child: pw.Text(
                          "No",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const EdgeInsets.all(10),
                        child: pw.Text(
                          "Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const EdgeInsets.all(10),
                        child: pw.Text(
                          "Name",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const EdgeInsets.all(10),
                        child: pw.Text(
                          "Qty",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const EdgeInsets.all(10),
                        child: pw.Text(
                          "QR Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Table Body with extract
                  ...allDataProducts
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save then Replace empty file with bytes data
    Uint8List bytes = await pdf.save();

    // Make empty file on directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Products-Catalogue-$dateNow.pdf');

    // write data in bytes to empty file
    await file.writeAsBytes(bytes);

    // open file
    await OpenFile.open(file.path);
  }

  Future<Map<String, dynamic>> getProductById(String code) async {
    try {
      var result =
          await db.collection("products").where("code", isEqualTo: code).get();
      if (result.docs.isEmpty) {
        throw "error";
      }

      Map<String, dynamic> data = result.docs.first.data();

      return {
        "error": false,
        "message": "Product has been found",
        "data": ProductModel.fromJson(data),
      };
    } catch (e) {
      return {"error": true, "message": "This product is not found"};
    }
  }
}
