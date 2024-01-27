import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController rateController = TextEditingController();


//variables
  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;
  double totalAmountAfterTax = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [




          // Main Part User input and calculation
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TextField(
                  controller: hoursController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(labelText: 'Number of Hours Worked'),
                ),

                TextField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(labelText: 'Hourly Rate'),
                ),

                SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: calculatePay,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: const Color.fromARGB(255, 13, 12, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), 
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Calculate', style: TextStyle(fontSize: 18.0, fontFamily: 'Helvetica')),
                  ),
                ),





                SizedBox(height: 24.0), 

                Text('Report', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'Helvetica')),
                Text('Regular Pay: $regularPay', style: TextStyle(fontSize: 18.0, fontFamily: 'Helvetica')),
                Text('Overtime Pay: $overtimePay', style: TextStyle(fontSize: 18.0, fontFamily: 'Helvetica')),
                Text('Total Pay (before tax): $totalPay', style: TextStyle(fontSize: 18.0, fontFamily: 'Helvetica')),
                Text('Tax: $tax', style: TextStyle(fontSize: 18.0, fontFamily: 'Helvetica')),
                // Underline the total amount after tax
                Text('Total Amount (after tax): ${totalAmountAfterTax.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18.0, decoration: TextDecoration.underline, fontFamily: 'Helvetica')),
              ],
            ),
          ),





          // name and college ID
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[800],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 8.0),

                Text(
                  'Saurav Gautam',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Helvetica'),
                ),

                Text(
                  '301286980',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Helvetica'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





  void calculatePay() {
    double hours = double.tryParse(hoursController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;

    if (hours <= 40) {
      regularPay = hours * rate;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * rate;
      overtimePay = (hours - 40) * rate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;
    totalAmountAfterTax = totalPay - tax;

    setState(() {});
  }
}
