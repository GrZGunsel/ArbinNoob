import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../core/constant/den_theme.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = PaymentConfig(
      amount: 10000, // Amount should be in paisa
      productIdentity: 'dell-g5-g5510-2021',
      productName: 'Dell G5 G5510 2021',
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'Khalti Bazaar',
      },
    );
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: DenTheme.secondaryColor),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            KhaltiScope.of(context).pay(
              config: config,
              preferences: [
                PaymentPreference.connectIPS,
                PaymentPreference.eBanking,
                PaymentPreference.sct,
              ],
              onSuccess: (val) {
                print("ustha noob $val");
              },
              onFailure: (val) {
                print("arbin noob $val");
              },
              onCancel: () {
                print("kaizo noob ");
              },
            );
          },
          child: Text('Launch Payment Interface'),
        ),
      ),
    ));
  }
}
