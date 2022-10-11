import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/data/services/utils_services.dart';
import 'package:newravelinestore/src/components/snackbar_ext.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({Key? key, required this.order}) : super(key: key);
  final OrderModel order;
  final utilsService = UtilsService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Pix Payment',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            //Pix Qr Code
            //#TODO Change this line
            QrImage(
              data: 'Te amo baixinha maluca 29/12/1995',
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.height / 3,
            ),
            //Outdate
            Text(
              'Overdue Date: ${utilsService.formatDateTime(order.dateOverdue)}',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            //Total
            Text(
              'Total: ${utilsService.priceToCurrencyString(order.total)}',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            //Button Copy and Paste
            SizedBox(
              width: MediaQuery.of(context).size.height / 3,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(
                    width: 2,
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  setGeneralMessage(
                    "Pix Code Copied",
                    messageSentence: order.copyAndPaste,
                  );
                },
                icon: const Icon(Icons.copy, size: 16),
                label: const Text(
                  'Copy Pix Code',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 2),
            //Button Copy and Paste
            SizedBox(
              width: MediaQuery.of(context).size.height / 3,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  primary: Colors.red,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                label: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
