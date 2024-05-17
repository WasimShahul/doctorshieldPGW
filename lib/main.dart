import 'package:flutter/material.dart';
import 'package:pgw_sdk/pgw_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _paymentStatus = 'Press the button to initiate payment';

  Future<void> initiatePayment() async {
    // Example payment details, replace with actual values
    double amount = 10.00; // Example amount
    String invoiceNo = "INV123456"; // Example invoice number
    String currency = "THB"; // Example currency

    try {
      // Assuming PGW SDK has an initialization method. Replace with actual usage.
      PGWSDK.initialize(publicKey: "your_public_key");

      // Assuming PGW SDK has a method to setup payment details. Replace with actual usage.
      PaymentRequest paymentRequest = PaymentRequest(
        amount: amount,
        invoiceNo: invoiceNo,
        currencyCode: currency,
        // Add additional required parameters according to the SDK's documentation
      );

      // Assuming PGW SDK has a method to start the payment process. Replace with actual usage.
      PaymentResponse response = await PGWSDK.proceedPayment(paymentRequest);

      // Handle the payment response
      setState(() {
        _paymentStatus = 'Payment Successful: ${response.transactionId}';
      });
    } catch (e) {
      setState(() {
        _paymentStatus = 'Payment Failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2C2P Payment UAT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: initiatePayment,
              child: Text('Initiate Payment'),
            ),
            SizedBox(height: 20),
            Text(_paymentStatus),
          ],
        ),
      ),
    );
  }
}
