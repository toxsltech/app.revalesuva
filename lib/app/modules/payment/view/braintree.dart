// import 'package:flutter_braintree/flutter_braintree.dart';

import 'dart:math';

import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/custom/currency_code.dart';
import 'package:flutter_paypal_native/models/custom/environment.dart';
import 'package:flutter_paypal_native/models/custom/order_callback.dart';
import 'package:flutter_paypal_native/models/custom/purchase_unit.dart';
import 'package:flutter_paypal_native/models/custom/user_action.dart';
import 'package:flutter_paypal_native/str_helper.dart';

import '../../../../export.dart';

class BrainTree extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BrainTree> {
  static final String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';
  // static final String tokenizationKey =
  //     'access_token\$sandbox\$tqjvp7rf36gyf9xv\$21425fe39ce71aeca32d248fa5658b75';
  // static final String tokenizationKey =
  //     'A21AALXQ9wpmC9KRntebGrfIAS4LX2F1i2Y87UItjRYRpiqIn54siUHMDeuOJWgSzpx5DwS-WAY4XJ_j1WtM86mJXOk_-awug';
  static final String secretKey =
      'EH403qE0sguGkHe2ip4_mXKj6iEx8fZLttWhGSSikoKCoBiIfKCStpAxW6jiXP2V8UZemVsdclhShe2k';
  static final String clientId =
      'AZ_lZnOg1ssXJ_5Dz8b76wmiefiXzCcvgxNuVaWJPMVxqXKnuM1z98MT7aETfb1lXcW9V4l-1GcSkdQU';

  // void showNonce(BraintreePaymentMethodNonce nonce) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Text('Payment method nonce:'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: <Widget>[
  //           Text('Nonce: ${nonce.nonce ?? ""}'),
  //           SizedBox(height: 16),
  //           Text('Type label: ${nonce.typeLabel ?? ""}'),
  //           SizedBox(height: 16),
  //           Text('Description: ${nonce.description ?? ""}'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void showNonce(List log) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${log ?? ""}'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  final _flutterPaypalNativePlugin = FlutterPaypalNative.instance;

  // log queue
  List<String> logQueue = [];

  @override
  void initState() {
    super.initState();
    initPayPal();
  }

  void initPayPal() async {
    //set debugMode for error logging
    FlutterPaypalNative.isDebugMode = true;

    //initiate payPal plugin
    await _flutterPaypalNativePlugin.init(
      //your app id !!! No Underscore!!! see readme.md for help
      returnUrl: "co.il.hadascohen://paypalpay",
      //client id from developer dashboard
      clientID: clientId,
      //sandbox, staging, live etc
      payPalEnvironment: FPayPalEnvironment.sandbox,
      //what currency do you plan to use? default is US dollars
      currencyCode: FPayPalCurrencyCode.usd,
      //action paynow?
      action: FPayPalUserAction.payNow,
    );

    //call backs for payment
    _flutterPaypalNativePlugin.setPayPalOrderCallback(
      callback: FPayPalOrderCallback(
        onCancel: () {
          //user canceled the payment
          showResult("cancel");
        },
        onSuccess: (data) {
          //successfully paid
          print("successfully paid");
          print("successfully paid $data");
          _flutterPaypalNativePlugin.removeAllPurchaseItems();
          debugPrint("Payment Data8 :${data.payerId}");
          debugPrint("Payment Data9 :${data.payer?.email?.value}");
          debugPrint(
              "Payment Data99 :${data.payer!.addresses!.first.fullAddress}");
          debugPrint("Payment Data77 :${data.cart!.intent}");
          debugPrint("Payment Data66 :${data.payer!.userId}");
          debugPrint(
              "Payment Data555 :${data.cart!.shippingMethods!.first.id}");
          //remove all items from queue

          String visitor = data.cart?.shippingAddress?.firstName ?? 'Visitor';
          String address =
              data.cart!.shippingAddress!.country ?? 'Unknown Address';
          String intent = data.cart!.intent ?? 'Unknown Address';
          String fullAddress =
              data.payer!.addresses!.first.fullAddress ?? 'Unknown Address';
          data.cart?.shippingAddress?.line1 ?? 'Unknown Address';
          showResult(
            "Order successful ${data.payerId ?? ""} - ${data.orderId ?? ""} - $visitor -$address ",
          );
          debugPrint("Payment Data1 :${data.payerId}");
          debugPrint("Payment Data3 :$fullAddress");
          debugPrint("Payment Data4 :$intent");
          debugPrint("Payment Data5 :${data.payer!.userId}");
          debugPrint("Payment Data6 :${data.cart!.shippingMethods!.first.id}");
        },
        onError: (data) {
          //an error occured
          showResult("error: ${data.reason}");
        },
        onShippingChange: (data) {
          //the user updated the shipping address
          showResult(
            "shipping change: ${data.shippingChangeAddress?.adminArea1 ?? ""}",
          );
        },
      ),
    );
  }

  // all to log queue
  showResult(String text) {
    logQueue.add(text);
    // showNonce(logQueue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            for (String t in logQueue) Text(t),
            ElevatedButton(
              child: const Text("Do payment"),
              onPressed: () {
                //add 1 item to cart. Max is 4!
                if (_flutterPaypalNativePlugin.canAddMorePurchaseUnit) {
                  _flutterPaypalNativePlugin.addPurchaseUnit(
                    FPayPalPurchaseUnit(
                      // random prices
                      amount: Random().nextDouble() * 100,

                      ///please use your own algorithm for referenceId. Maybe ProductID?
                      referenceId: FPayPalStrHelper.getRandomString(16),
                    ),
                  );
                }
                // initPayPal();
                _flutterPaypalNativePlugin.makeOrder(
                  action: FPayPalUserAction.payNow,
                );
              },
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     var request = BraintreeDropInRequest(
            //       tokenizationKey: tokenizationKey,
            //       collectDeviceData: true,
            //       vaultManagerEnabled: true,
            //       requestThreeDSecureVerification: true,
            //       email: "test@email.com",
            //       billingAddress: BraintreeBillingAddress(
            //         givenName: "Jill",
            //         surname: "Doe",
            //         phoneNumber: "5551234567",
            //         streetAddress: "555 Smith St",
            //         extendedAddress: "#2",
            //         locality: "Chicago",
            //         region: "IL",
            //         postalCode: "12345",
            //         countryCodeAlpha2: "US",
            //       ),
            //       googlePaymentRequest: BraintreeGooglePaymentRequest(
            //         totalPrice: '4.20',
            //         currencyCode: 'USD',
            //         billingAddressRequired: false,
            //       ),
            //       applePayRequest: BraintreeApplePayRequest(
            //           currencyCode: 'USD',
            //           supportedNetworks: [
            //             ApplePaySupportedNetworks.visa,
            //             ApplePaySupportedNetworks.masterCard,
            //             // ApplePaySupportedNetworks.amex,
            //             // ApplePaySupportedNetworks.discover,
            //           ],
            //           countryCode: 'US',
            //           merchantIdentifier: '',
            //           displayName: '',
            //           paymentSummaryItems: []),
            //       paypalRequest: BraintreePayPalRequest(
            //         amount: '4.20',
            //         displayName: 'Example company',
            //       ),
            //       cardEnabled: true,
            //     );
            //     final result = await BraintreeDropIn.start(request);
            //     if (result != null) {
            //       showNonce(result.paymentMethodNonce);
            //     }
            //   },
            //   child: Text('LAUNCH NATIVE DROP-IN'),
            // ),
          ],
        ),
      ),
    );
  }
}
